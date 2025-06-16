# -*- encoding: utf-8 -*-
# stub: opentelemetry-resource_detectors 0.24.2 ruby lib

Gem::Specification.new do |s|
  s.name = "opentelemetry-resource_detectors".freeze
  s.version = "0.24.2".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/issues", "changelog_uri" => "https://rubydoc.info/gems/opentelemetry-resource_detectors/0.24.2/file/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/opentelemetry-resource_detectors/0.24.2", "source_code_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/resource_detectors" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenTelemetry Authors".freeze]
  s.date = "2023-09-07"
  s.description = "Resource detection helpers for OpenTelemetry".freeze
  s.email = ["cncf-opentelemetry-contributors@lists.cncf.io".freeze]
  s.homepage = "https://github.com/open-telemetry/opentelemetry-ruby-contrib".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.post_install_message = "This gem has been deprecated. Please use opentelemetry-resource-detector-azure or opentelemetry-resource-detector-google_cloud_platform onwards.".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 3.0".freeze)
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Resource detection helpers for OpenTelemetry".freeze

  s.installed_by_version = "3.6.7".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<google-cloud-env>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-sdk>.freeze, ["~> 1.0".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.4".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<rake>.freeze, ["~> 13.0".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.56.1".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.17".freeze])
  s.add_development_dependency(%q<webmock>.freeze, ["~> 3.18.1".freeze])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9".freeze])
end
