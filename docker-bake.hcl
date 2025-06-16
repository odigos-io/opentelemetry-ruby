group "default" {
  targets = [
    "ruby31-arm64", "ruby31-amd64",
    "ruby32-arm64", "ruby32-amd64",
    "ruby33-arm64", "ruby33-amd64",
    "ruby34-arm64", "ruby34-amd64",
  ]
}

target "ruby-base" {
  context    = "."
  dockerfile = "Dockerfile"
  target     = "output"
  build_args = {
    RUBY_VERSION = "${RUBY_VERSION}"
  }
}

target "ruby31-arm64" {
  inherits = ["ruby-base"]
  platforms = ["linux/arm64"]
  tags     = ["otel-ruby:3.1-arm64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.1-arm64.tar"]
  args = {
    RUBY_VERSION = "3.1"
  }
}
target "ruby31-amd64" {
  inherits = ["ruby-base"]
  platforms = ["linux/amd64"]
  tags     = ["otel-ruby:3.1-amd64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.1-amd64.tar"]
  args = {
    RUBY_VERSION = "3.1"
  }
}

target "ruby32-arm64" {
  inherits = ["ruby-base"]
  platforms = ["linux/arm64"]
  tags     = ["otel-ruby:3.2-arm64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.2-arm64.tar"]
  args = {
    RUBY_VERSION = "3.2"
  }
}
target "ruby32-amd64" {
  inherits = ["ruby-base"]
  platforms = ["linux/amd64"]
  tags     = ["otel-ruby:3.2-amd64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.2-amd64.tar"]
  args = {
    RUBY_VERSION = "3.2"
  }
}

target "ruby33-arm64" {
  inherits = ["ruby-base"]
  platforms = ["linux/arm64"]
  tags     = ["otel-ruby:3.3-arm64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.3-arm64.tar"]
  args = {
    RUBY_VERSION = "3.3"
  }
}
target "ruby33-amd64" {
  inherits = ["ruby-base"]
  platforms = ["linux/amd64"]
  tags     = ["otel-ruby:3.3-amd64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.3-amd64.tar"]
  args = {
    RUBY_VERSION = "3.3"
  }
}

target "ruby34-arm64" {
  inherits = ["ruby-base"]
  platforms = ["linux/arm64"]
  tags     = ["otel-ruby:3.4-arm64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.4-arm64.tar"]
  args = {
    RUBY_VERSION = "3.4"
  }
}
target "ruby34-amd64" {
  inherits = ["ruby-base"]
  platforms = ["linux/amd64"]
  tags     = ["otel-ruby:3.4-amd64"]
  output = ["type=oci,dest=tmp/otel-ruby-3.4-amd64.tar"]
  args = {
    RUBY_VERSION = "3.4"
  }
}
