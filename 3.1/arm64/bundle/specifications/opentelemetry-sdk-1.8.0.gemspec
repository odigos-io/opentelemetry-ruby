# -*- encoding: utf-8 -*-
# stub: opentelemetry-sdk 1.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "opentelemetry-sdk".freeze
  s.version = "1.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/open-telemetry/opentelemetry-ruby/issues", "changelog_uri" => "https://open-telemetry.github.io/opentelemetry-ruby/opentelemetry-sdk/v1.8.0/file.CHANGELOG.html", "documentation_uri" => "https://open-telemetry.github.io/opentelemetry-ruby/opentelemetry-sdk/v1.8.0", "source_code_uri" => "https://github.com/open-telemetry/opentelemetry-ruby/tree/main/sdk" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenTelemetry Authors".freeze]
  s.date = "2025-02-25"
  s.description = "A stats collection and distributed tracing framework".freeze
  s.email = ["cncf-opentelemetry-contributors@lists.cncf.io".freeze]
  s.homepage = "https://github.com/open-telemetry/opentelemetry-ruby".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.3.27".freeze
  s.summary = "A stats collection and distributed tracing framework".freeze

  s.installed_by_version = "3.3.27" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<opentelemetry-api>.freeze, ["~> 1.1"])
    s.add_runtime_dependency(%q<opentelemetry-common>.freeze, ["~> 0.20"])
    s.add_runtime_dependency(%q<opentelemetry-registry>.freeze, ["~> 0.2"])
    s.add_runtime_dependency(%q<opentelemetry-semantic_conventions>.freeze, [">= 0"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.17"])
    s.add_development_dependency(%q<faraday>.freeze, ["~> 0.13"])
    s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_development_dependency(%q<opentelemetry-exporter-zipkin>.freeze, ["~> 0.19.0"])
    s.add_development_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.20"])
    s.add_development_dependency(%q<opentelemetry-test-helpers>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.65"])
    s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.17"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_development_dependency(%q<yard-doctest>.freeze, ["~> 0.1.6"])
    s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
  else
    s.add_dependency(%q<opentelemetry-api>.freeze, ["~> 1.1"])
    s.add_dependency(%q<opentelemetry-common>.freeze, ["~> 0.20"])
    s.add_dependency(%q<opentelemetry-registry>.freeze, ["~> 0.2"])
    s.add_dependency(%q<opentelemetry-semantic_conventions>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.17"])
    s.add_dependency(%q<faraday>.freeze, ["~> 0.13"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<opentelemetry-exporter-zipkin>.freeze, ["~> 0.19.0"])
    s.add_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.20"])
    s.add_dependency(%q<opentelemetry-test-helpers>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, ["~> 12.0"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 1.65"])
    s.add_dependency(%q<simplecov>.freeze, ["~> 0.17"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9"])
    s.add_dependency(%q<yard-doctest>.freeze, ["~> 0.1.6"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
  end
end
