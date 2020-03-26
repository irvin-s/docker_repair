FROM ruby:2.3

# Add nodejs and erlang
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && dpkg -i erlang-solutions_1.0_all.deb && wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc && apt-key add erlang_solutions.asc

# Install other stable dependencies that don't change often
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-utils nodejs postgresql-client elixir python3-pip python3-setuptools && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

COPY Gemfile Gemfile.lock ./
COPY mix.* ./
COPY package.json package-lock.json ./

COPY . .

# install deps - ruby, elixir, python, node - in that order, compile assets, set path

RUN gem install bundler --conservative && bundle install && mix local.hex --force && mix deps.get && pip3 install --user pylint && npm install && rake assets:precompile && export PATH=$HOME/.local/bin:$PATH

EXPOSE 3000
ENV PORT 3000
ENV RACK_ENV production
# Start the main process.
CMD ["bash", "-c", "bundle exec puma -t 5:5 -p $PORT"]