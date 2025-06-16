ARG RUBY_VERSION
FROM --platform=$TARGETPLATFORM ruby:${RUBY_VERSION} AS builder

WORKDIR /
COPY ./Gemfile ./Gemfile

# Use the platforms you need, or leave it empty for default.
# Available options are: aarch64-linux-gnu aarch64-linux-musl arm64-darwin ruby x86-linux-gnu x86-linux-musl x86_64-darwin x86_64-linux-gnu x86_64-linux-musl
ENV PLATFORMS="ruby"
RUN for platform in $PLATFORMS; do \
  bundle lock --add-platform $platform ; \
  done

RUN bundle install

FROM scratch AS output
COPY --from=builder . .
CMD ["ls", "-l", "."]
