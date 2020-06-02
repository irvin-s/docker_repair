FROM node

RUN apt-get update && apt-get -y install ruby-full rubygems-integration
RUN gem install sass compass

RUN adduser --disabled-password --gecos '' noroot && adduser noroot sudo && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER noroot

