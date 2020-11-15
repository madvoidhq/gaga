ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION} AS alpine

FROM elixir:1.9.0-alpine AS builder

# set build ENV
ENV MIX_ENV=prod

# install build dependencies
RUN apk add --no-cache \
    build-base \
    git \
    npm \
    python \
    && rm -rf /tmp/* /var/cache/apk/*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get --only prod, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm ci --prefix ./assets --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run deploy --prefix ./assets
RUN mix phx.digest

# compile and build release
COPY lib ./lib/
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine AS app

LABEL maintainer="Jean-Paul Bonnetouche" \
    org.opencontainers.image.vendor="Madvoid" \
    org.opencontainers.image.title="Gaga" \
    org.opencontainers.image.description="Simple remote planning poker" \
    org.opencontainers.image.licenses="MIT"

ENV PORT="4000" \
    ROOT_URL="http://localhost:4000"

RUN apk --update --no-cache add \
    ncurses-libs \
    openssl \
    && rm -rf /tmp/* /var/cache/apk/*

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=builder --chown=nobody:nobody /app/_build/prod/rel/gaga ./

ENV HOME=/app

EXPOSE 4000/tcp
CMD ["bin/gaga", "start"]
