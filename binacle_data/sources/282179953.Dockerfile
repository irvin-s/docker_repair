# Current LTS
FROM bitnami/node:10.15.3
LABEL maintainer="Bitnami <webdev@bitnami.com>"

# Dependencies
RUN install_packages gnupg
RUN install_packages openssh-client apt-transport-https libpng-dev

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    install_packages yarn

WORKDIR /app

# Install
RUN yarn global add lerna

# Documentation port
EXPOSE 8080

# By default, generate the Docs and serve them
CMD ["yarn", "run", "docs"]
