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
Dir.glob("#{gem_path}/gems/*").each do |file|
  $LOAD_PATH.unshift("#{file}/lib")
end

require 'bundler'

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
