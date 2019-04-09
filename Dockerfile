FROM bitwalker/alpine-elixir-phoenix:latest
LABEL maintainer="Leonardo Ribeiro <contato@leoribeiroweb.com.br>"

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

WORKDIR /app

EXPOSE 4000
ENV PORT=4000 MIX_ENV=prod

# Cache elixir deps
ADD mix.exs mix.lock ./

# Install Hex+Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

RUN mix do deps.get, deps.compile

ADD . .

CMD ["mix", "phx.server"]
