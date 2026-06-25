# Pin the base image to an immutable digest (alpine 3.24.1) so the build cannot
# silently pull a newer, potentially vulnerable `alpine:latest`. This stage is
# only used to assemble files into the final scratch image; no OS packages ship.
FROM --platform=$BUILDPLATFORM alpine:3.24@sha256:28bd5fe8b56d1bd048e5babf5b10710ebe0bae67db86916198a6eec434943f8b AS ruby-community-build
WORKDIR /opentelemetry-ruby
ARG TARGETARCH
ARG RUBY_VERSIONS="3.1 3.2 3.3 3.4"
ENV RUBY_VERSIONS=${RUBY_VERSIONS}
COPY . .

# create a directory for the instrumentations and put each ruby version in it
RUN mkdir -p /instrumentations/ruby

# Move the pre-compiled binaries for the target architecture to the final location
RUN for v in ${RUBY_VERSIONS}; do \
    mkdir -p /instrumentations/ruby/$v; \
    mv ./$v/${TARGETARCH}/* /instrumentations/ruby/$v/; \
    cp ./Gemfile /instrumentations/ruby/$v/Gemfile; \
    cp ./index.rb /instrumentations/ruby/$v/index.rb; \
    done

FROM scratch
WORKDIR /instrumentations

COPY --from=ruby-community-build /instrumentations .
