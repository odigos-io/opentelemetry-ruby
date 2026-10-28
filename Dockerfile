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

# Install gems using default bundler location (/usr/local/bundle)
# Remove bundler specs from the bundle since bundler is a tool, not a runtime dependency
# This prevents version conflicts when bundler runs at runtime
# Gems the base image already provides (e.g. logger, a bundled gem since Ruby 4.0) are skipped by bundler,
# so install them into the bundle as well, since the agent is loaded from this directory alone
RUN bundle install && \
    bundle exec ruby -e 'Bundler.load.specs.each { |s| puts "#{s.name} #{s.version}" unless s.full_gem_path.start_with?("/usr/local/bundle") }' | \
    while read -r name version; do \
      gem install "$name" -v "$version" --install-dir /usr/local/bundle --ignore-dependencies --no-document; \
    done && \
    find /usr/local/bundle -name 'bundler-*.gemspec' -delete 2>/dev/null || true

FROM scratch AS output
COPY --from=builder . .
CMD ["ls", "-l", "."]
