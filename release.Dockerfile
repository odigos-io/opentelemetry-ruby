FROM --platform=$BUILDPLATFORM alpine AS ruby-community-build
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
    done

FROM scratch
WORKDIR /instrumentations

COPY --from=ruby-community-build /instrumentations .
