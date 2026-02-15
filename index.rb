# refs:
#  - https://github.com/newrelic/newrelic-ruby-agent/blob/dev/lib/boot/strap.rb
#  - https://github.com/open-telemetry/opentelemetry-operator/blob/b4e22034a1cdc498e3f9e0cb95f7c6204972f42c/autoinstrumentation/ruby/src/autoinstrumentation.rb

module OTelBundlerPatch
  def require(*_groups)
    super
    require_otel
  end

  # def require_resources
  #   additional_resource = ::OpenTelemetry::SDK::Resources::Resource.create({})
  #   additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::Container.detect) if defined? ::OpenTelemetry::Resource::Detector::Container
  #   additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::GoogleCloudPlatform.detect) if defined? ::OpenTelemetry::Resource::Detector::GoogleCloudPlatform
  #   additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::Azure.detect) if defined? ::OpenTelemetry::Resource::Detector::Azure
  #   additional_resource
  # end

  def require_otel
    lib = File.expand_path('..', __dir__)
    $LOAD_PATH.reject! { |path| path.include?('zero-code-instrumentation') }
    $LOAD_PATH.unshift(lib)

    begin
      OpenTelemetry::SDK.configure do |c|
        c.service_name = ENV['OTEL_SERVICE_NAME']
        # c.resource = require_resources
        c.use_all # enables all instrumentation!
      end
      OpenTelemetry.logger.info { 'OpenTelemetry initialized' }
    rescue StandardError => e
      OpenTelemetry.logger.info { "OpenTelemetry failed to initialize. Error: #{e.message}" }
    end
  end
end

gem_path = ENV['ODIGOS_GEM_PATH'] || Gem.dir
# Add gem lib directories to LOAD_PATH
# Handle both flat structure (bundle/gems/) and versioned structure (bundle/ruby/X.Y/gems/)
gem_dirs = []

# Check for flat structure first (bundle/gems/)
flat_gems = File.join(gem_path, 'gems')
gem_dirs << flat_gems if Dir.exist?(flat_gems)

# Also check for versioned structure (bundle/ruby/X.Y/gems/)
if Dir.exist?(File.join(gem_path, 'ruby'))
  Dir.glob(File.join(gem_path, 'ruby', '*', 'gems')).each do |dir|
    gem_dirs << dir if Dir.exist?(dir)
  end
end

# Add each gem's lib directory to LOAD_PATH
gem_dirs.each do |gems_dir|
  Dir.glob(File.join(gems_dir, '*')).each do |gem_dir|
    lib_dir = File.join(gem_dir, 'lib')
    $LOAD_PATH.unshift(lib_dir) if File.directory?(lib_dir)
  end
end

# Clean up any conflicting bundler specs before requiring bundler
# This prevents "Bundler::CorruptBundlerInstallError" when there are version mismatches
# We keep only the bundler spec that matches the actual installed bundler gem
begin
  # Find specifications directory (handle both flat and versioned structures)
  specs_dirs = []
  flat_specs = File.join(gem_path, 'specifications')
  specs_dirs << flat_specs if Dir.exist?(flat_specs)
  
  # Also check versioned structure
  if Dir.exist?(File.join(gem_path, 'ruby'))
    Dir.glob(File.join(gem_path, 'ruby', '*', 'specifications')).each do |dir|
      specs_dirs << dir if Dir.exist?(dir)
    end
  end
  
  specs_dirs.each do |specs_dir|
    bundler_specs = Dir.glob(File.join(specs_dir, 'bundler-*.gemspec')).sort
    if bundler_specs.length > 1
      # If multiple bundler specs exist, keep only the latest one (highest version)
      # This handles cases where old bundler specs weren't cleaned up during build
      bundler_specs[0..-2].each do |spec_file|
        File.delete(spec_file) rescue nil
      end
    end
  end
rescue StandardError => e
  # If cleanup fails, log but don't fail - bundler might still work
  warn "Warning: Failed to clean up bundler specs: #{e.message}" if ENV['DEBUG']
end

# Load bundler with error handling for version conflicts
begin
  require 'bundler'
rescue => e
  # If we get a bundler version conflict error, try to fix it by removing conflicting specs
  # Check both the error class name and message to catch Bundler::CorruptBundlerInstallError
  if e.class.name.include?('CorruptBundlerInstallError') ||
     e.message.include?('does not match the version of the specification') ||
     e.message.include?('CorruptBundlerInstallError')
    begin
      # Find and clean all specifications directories (handle both flat and versioned structures)
      specs_dirs = []
      flat_specs = File.join(gem_path, 'specifications')
      specs_dirs << flat_specs if Dir.exist?(flat_specs)
      
      if Dir.exist?(File.join(gem_path, 'ruby'))
        Dir.glob(File.join(gem_path, 'ruby', '*', 'specifications')).each do |dir|
          specs_dirs << dir if Dir.exist?(dir)
        end
      end
      
      specs_dirs.each do |specs_dir|
        # Remove all bundler specs and let bundler reinstall its own
        Dir.glob(File.join(specs_dir, 'bundler-*.gemspec')).each do |spec_file|
          File.delete(spec_file) rescue nil
        end
      end
      # Retry loading bundler
      require 'bundler'
    rescue => retry_error
      # If retry fails, raise the original error
      raise e
    end
  else
    # Re-raise if it's not a bundler version conflict
    raise
  end
end

require 'opentelemetry-api'
require 'opentelemetry-sdk'
require 'opentelemetry-exporter-otlp'
require 'opentelemetry-instrumentation-all'

# require 'opentelemetry-resource_detectors'
# require 'opentelemetry-resource-detector-container'
# require 'opentelemetry-resource-detector-google_cloud_platform'
# require 'opentelemetry-resource-detector-azure'

require 'opentelemetry-helpers-mysql'
require 'opentelemetry-helpers-sql'
require 'opentelemetry-helpers-sql-obfuscation'

Bundler::Runtime.prepend(OTelBundlerPatch)
Bundler.require if ENV['REQUIRE_BUNDLER'].to_s == 'true'
