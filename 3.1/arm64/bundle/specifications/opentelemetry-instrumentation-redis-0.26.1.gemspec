# -*- encoding: utf-8 -*-
# stub: opentelemetry-instrumentation-redis 0.26.1 ruby lib

Gem::Specification.new do |s|
  s.name = "opentelemetry-instrumentation-redis".freeze
  s.version = "0.26.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/issues", "changelog_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-redis/0.26.1/file/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-redis/0.26.1", "source_code_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation/redis" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenTelemetry Authors".freeze]
  s.date = "2025-02-04"
  s.description = "Redis instrumentation for the OpenTelemetry framework".freeze
  s.email = ["cncf-opentelemetry-contributors@lists.cncf.io".freeze]
  s.homepage = "https://github.com/open-telemetry/opentelemetry-ruby-contrib".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.3.27".freeze
  s.summary = "Redis instrumentation for the OpenTelemetry framework".freeze

  s.installed_by_version = "3.3.27" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<opentelemetry-api>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.23.0"])
    s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.5"])
    s.add_development_dependency(%q<bundler>.freeze, ["~> 2.4"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<opentelemetry-sdk>.freeze, ["~> 1.1"])
    s.add_development_dependency(%q<opentelemetry-test-helpers>.freeze, ["~> 0.3"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.71.0"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.23.0"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.22.0"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
  else
    s.add_dependency(%q<opentelemetry-api>.freeze, ["~> 1.0"])
    s.add_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.23.0"])
    s.add_dependency(%q<appraisal>.freeze, ["~> 2.5"])
    s.add_dependency(%q<bundler>.freeze, ["~> 2.4"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<opentelemetry-sdk>.freeze, ["~> 1.1"])
    s.add_dependency(%q<opentelemetry-test-helpers>.freeze, ["~> 0.3"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.71.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, ["~> 1.23.0"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.22.0"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
  end
end
