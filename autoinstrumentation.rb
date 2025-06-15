module OTelBundlerPatch
  def require(*_groups)
    super
    require_otel
  end

  def require_resources
    env = ENV['OTEL_RUBY_RESOURCE_DETECTORS'].to_s
    additional_resource = ::OpenTelemetry::SDK::Resources::Resource.create({})

    additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::Container.detect) if defined? ::OpenTelemetry::Resource::Detector::Container
    additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::GoogleCloudPlatform.detect) if defined? ::OpenTelemetry::Resource::Detector::GoogleCloudPlatform
    additional_resource = additional_resource.merge(::OpenTelemetry::Resource::Detector::Azure.detect) if defined? ::OpenTelemetry::Resource::Detector::Azure

    additional_resource
  end

  def require_otel
    lib = File.expand_path('..', __dir__)
    $LOAD_PATH.reject! { |path| path.include?('zero-code-instrumentation') }
    $LOAD_PATH.unshift(lib)

    begin
      OpenTelemetry::SDK.configure do |c|
        c.resource = require_resources
        c.use_all # enables all instrumentation!
      end
      OpenTelemetry.logger.info { 'Auto-instrumentation initialized' }
    rescue StandardError => e
      OpenTelemetry.logger.info { "Auto-instrumentation failed to initialize. Error: #{e.message}" }
    end
  end
end

additional_gem_path = ENV['ADDITIONAL_GEM_PATH'] || Gem.dir
puts "Loading additional gems from path #{additional_gem_path}"

Dir.glob("#{additional_gem_path}/gems/*").each do |file|
  # google-protobuf is used for otel trace exporter
  if (file.include?('opentelemetry') || file.include?('google'))
    puts "Unshift #{file.inspect}"
    $LOAD_PATH.unshift("#{file}/lib")
  end
end

require 'bundler'

require 'opentelemetry-api'
require 'opentelemetry-sdk'
require 'opentelemetry-exporter-otlp'
require 'opentelemetry-instrumentation-all'

require 'opentelemetry-resource_detectors'
require 'opentelemetry-resource-detector-container'
require 'opentelemetry-resource-detector-google_cloud_platform'
require 'opentelemetry-resource-detector-azure'

require 'opentelemetry-helpers-mysql'
require 'opentelemetry-helpers-sql'
require 'opentelemetry-helpers-sql-obfuscation'

Bundler::Runtime.prepend(OTelBundlerPatch)
Bundler.require if ENV['REQUIRE_BUNDLER'].to_s == 'true'


# <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require': cannot load such file -- faraday (LoadError)
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/bundle/gems/google-cloud-env-2.3.1/lib/google/cloud/env/compute_metadata.rb:18:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/bundle/gems/google-cloud-env-2.3.1/lib/google/cloud/env.rb:17:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/bundle/gems/google-cloud-env-2.3.1/lib/google-cloud-env.rb:16:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/bundle/gems/opentelemetry-resource_detectors-0.24.2/lib/opentelemetry/resource/detectors/google_cloud_platform.rb:7:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/bundle/gems/opentelemetry-resource_detectors-0.24.2/lib/opentelemetry/resource/detectors.rb:9:in '<top (required)>'
#     from /var/odigos/ruby/bundle/gems/opentelemetry-resource_detectors-0.24.2/lib/opentelemetry-resource_detectors.rb:7:in 'Kernel#require_relative'
#     from /var/odigos/ruby/bundle/gems/opentelemetry-resource_detectors-0.24.2/lib/opentelemetry-resource_detectors.rb:7:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from /var/odigos/ruby/autoinstrumentation.rb:53:in '<top (required)>'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'
#     from <internal:/usr/local/lib/ruby/3.4.0/rubygems/core_ext/kernel_require.rb>:136:in 'Kernel#require'

# Loading additional gems from path /var/odigos/ruby/bundle
# Unshift "/var/odigos/ruby/bundle/gems/google-cloud-env-2.3.1"
# Unshift "/var/odigos/ruby/bundle/gems/google-protobuf-4.31.1-aarch64-linux-gnu"
# Unshift "/var/odigos/ruby/bundle/gems/googleapis-common-protos-types-1.20.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-api-1.5.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-common-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-exporter-otlp-0.30.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-helpers-mysql-0.2.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-helpers-sql-0.1.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-helpers-sql-obfuscation-0.3.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-action_mailer-0.4.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-action_pack-0.12.2"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-action_view-0.9.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-active_job-0.8.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-active_model_serializers-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-active_record-0.9.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-active_storage-0.1.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-active_support-0.8.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-all-0.77.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-aws_lambda-0.3.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-aws_sdk-0.8.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-base-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-bunny-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-concurrent_ruby-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-dalli-0.27.3"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-delayed_job-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-ethon-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-excon-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-faraday-0.27.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-grape-0.3.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-graphql-0.29.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-grpc-0.2.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-gruf-0.3.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-http-0.24.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-http_client-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-koala-0.21.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-lmdb-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-mongo-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-mysql2-0.29.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-net_http-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-pg-0.30.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-que-0.9.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-racecar-0.4.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-rack-0.26.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-rails-0.36.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-rake-0.3.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-rdkafka-0.7.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-redis-0.26.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-resque-0.6.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-restclient-0.23.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-ruby_kafka-0.22.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-sidekiq-0.26.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-sinatra-0.25.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-instrumentation-trilogy-0.61.1"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-registry-0.4.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-resource-detector-azure-0.2.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-resource-detector-container-0.2.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-resource-detector-google_cloud_platform-0.2.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-resource_detectors-0.24.2"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-sdk-1.8.0"
# Unshift "/var/odigos/ruby/bundle/gems/opentelemetry-semantic_conventions-1.11.0"
# stream closed EOF for default/geolocation-6f6d665bbb-7r82r (geolocation)
