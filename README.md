# Simple Bank API

[![CircleCI](https://circleci.com/gh/leoribeirowebmaster/simple_bank_api/tree/develop.svg?style=svg)](https://circleci.com/gh/leoribeirowebmaster/simple_bank_api/tree/develop)

Simple banking project where it is possible to register and make transfers to other users.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* Elixir >1.5
* Elang >20
* Postgres

### Installing

```
git clone https://github.com/leoribeirowebmaster/simple_bank_api.git
cd simple_bank_api
```

Update postgres connection on config/dev.exs
```
config :simple_bank_api, SimpleBankApi.Repo,
  username: "",
  password: "",
  database: "",
  hostname: "",
  pool_size: 10
```

```bash
mix local.hex --force && mix local.rebar --force
mix deps.get
mix ecto.create #create database
mix ecto.migrate #create tables
```

### Running development

```
mix phx.server
```

The server is running on https://localhost:4000

## Running the tests

```
mix test
```

## Deployment

This project is implemented CI / CD using [circleci](https://circleci.com/), at each commit the code is tested, when the merge for the branch release is made a deploy to the production environment: https://simple-bank-api.herokuapp.com/

## Built With

* [Elixir](https://elixir-lang.org/) - Elixir is a dynamic, functional language designed for building scalable and maintainable applications.
* [Phoenix](https://phoenixframework.org/) - A productive web framework that does not compromise speed or maintainability.
