FROM node:7.8-slim

# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
RUN export PATH="$PATH:`yarn global bin`"

# Support for Flow
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  ocaml libelf-dev

# Create app directory
RUN mkdir -p /app
WORKDIR /app

# Bundle app source
COPY . .

ENTRYPOINT ["sh", "./docker-entrypoint.sh"]

CMD ["yarn", "start"]
