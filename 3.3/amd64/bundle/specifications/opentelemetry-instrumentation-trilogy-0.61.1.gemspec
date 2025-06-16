# -*- encoding: utf-8 -*-
# stub: opentelemetry-instrumentation-trilogy 0.61.1 ruby lib

Gem::Specification.new do |s|
  s.name = "opentelemetry-instrumentation-trilogy".freeze
  s.version = "0.61.1".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/issues", "changelog_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-trilogy/0.61.1/file/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-trilogy/0.61.1", "source_code_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation/trilogy" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenTelemetry Authors".freeze]
  s.date = "2025-04-16"
  s.description = "Adds auto instrumentation that includes SQL metadata".freeze
  s.email = ["cncf-opentelemetry-contributors@lists.cncf.io".freeze]
  s.homepage = "https://github.com/open-telemetry/opentelemetry-ruby-contrib".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.3.27".freeze
  s.summary = "Trilogy instrumentation for the OpenTelemetry framework".freeze

  s.installed_by_version = "3.5.22".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<opentelemetry-api>.freeze, ["~> 1.0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-helpers-mysql>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-helpers-sql>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-helpers-sql-obfuscation>.freeze, [">= 0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.23.0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-semantic_conventions>.freeze, [">= 1.8.0".freeze])
end
