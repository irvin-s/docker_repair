FROM alpine
MAINTAINER Thomas VIAL

# Update and install packages
RUN apk update
RUN apk add --no-cache php5-cli php5-curl php5-json php5-phar php5-openssl php5-ctype php5-dom curl zsh git && rm -rf /var/cache/apk/*

# Clone oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh/

# Install Behat
RUN mkdir -p /root/composer
ADD composer.json /root/composer/composer.json
RUN cd /root/composer && curl http://getcomposer.org/installer | php
RUN cd /root/composer && php composer.phar install --prefer-source

# Create a new zsh configuration from the provided template
ADD .zshrc /root/.zshrc

# Set Workdir and ENV
RUN mkdir -p /root/project
WORKDIR /root/project
ENV PATH $PATH:/root/composer/bin/
CMD ["behat"]
