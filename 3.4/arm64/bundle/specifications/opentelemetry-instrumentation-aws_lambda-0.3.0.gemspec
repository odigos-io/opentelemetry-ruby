# -*- encoding: utf-8 -*-
# stub: opentelemetry-instrumentation-aws_lambda 0.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "opentelemetry-instrumentation-aws_lambda".freeze
  s.version = "0.3.0".freeze

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "bug_tracker_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/issues", "changelog_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-aws_lambda/0.3.0/file/CHANGELOG.md", "documentation_uri" => "https://rubydoc.info/gems/opentelemetry-instrumentation-aws_lambda/0.3.0", "source_code_uri" => "https://github.com/open-telemetry/opentelemetry-ruby-contrib/tree/main/instrumentation/aws_lambda" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["OpenTelemetry Authors".freeze]
  s.date = "2025-02-04"
  s.description = "AWS Lambda instrumentation for the OpenTelemetry framework".freeze
  s.email = ["cncf-opentelemetry-contributors@lists.cncf.io".freeze]
  s.homepage = "https://github.com/open-telemetry/opentelemetry-ruby-contrib".freeze
  s.licenses = ["Apache-2.0".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 3.1".freeze)
  s.rubygems_version = "3.3.27".freeze
  s.summary = "AWS Lambda instrumentation for the OpenTelemetry framework".freeze

  s.installed_by_version = "3.6.7".freeze

  s.specification_version = 4

  s.add_runtime_dependency(%q<opentelemetry-api>.freeze, ["~> 1.0".freeze])
  s.add_runtime_dependency(%q<opentelemetry-instrumentation-base>.freeze, ["~> 0.23.0".freeze])
  s.add_development_dependency(%q<appraisal>.freeze, ["~> 2.5".freeze])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.4".freeze])
  s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0".freeze])
  s.add_development_dependency(%q<opentelemetry-sdk>.freeze, ["~> 1.1".freeze])
  s.add_development_dependency(%q<opentelemetry-test-helpers>.freeze, ["~> 0.3".freeze])
  s.add_development_dependency(%q<pry>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rspec-mocks>.freeze, [">= 0".freeze])
  s.add_development_dependency(%q<rubocop>.freeze, ["~> 1.71.0".freeze])
  s.add_development_dependency(%q<rubocop-performance>.freeze, ["~> 1.23.0".freeze])
  s.add_development_dependency(%q<simplecov>.freeze, ["~> 0.22.0".freeze])
  s.add_development_dependency(%q<webmock>.freeze, ["~> 3.24.0".freeze])
  s.add_development_dependency(%q<yard>.freeze, ["~> 0.9".freeze])
end
