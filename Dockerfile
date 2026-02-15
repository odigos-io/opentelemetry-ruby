ARG RUBY_VERSION
FROM --platform=$TARGETPLATFORM ruby:${RUBY_VERSION} AS builder

WORKDIR /
COPY ./Gemfile ./Gemfile
RUN gem install bundler

# Use the platforms you need, or leave it empty for default.
# Available options are: aarch64-linux-gnu aarch64-linux-musl arm64-darwin ruby x86-linux-gnu x86-linux-musl x86_64-darwin x86_64-linux-gnu x86_64-linux-musl
ENV PLATFORMS="ruby"
RUN for platform in $PLATFORMS; do \
  bundle lock --add-platform $platform ; \
  done

# Install gems to a specific path
# Remove bundler specs from the bundle since bundler is a tool, not a runtime dependency
# This prevents version conflicts when bundler runs at runtime
RUN bundle config set --local path 'bundle' && \
    bundle install && \
    find bundle -name 'bundler-*.gemspec' -delete 2>/dev/null || true

FROM scratch AS output
COPY --from=builder . .
CMD ["ls", "-l", "."]
