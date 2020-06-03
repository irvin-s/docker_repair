# Latest version of Erlang-based Elixir installation: https://hub.docker.com/_/elixir/
FROM elixir:1.6

# Create and set home directory
ENV HOME /rms_phoenix_app
WORKDIR $HOME

# Configure required environment
ENV MIX_ENV prod

# Set and expose PORT environmental variable
ENV PORT ${PORT:-4000}
EXPOSE $PORT

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile

# Run Ecto migrations and Phoenix server as an initial command
CMD mix phx.server
