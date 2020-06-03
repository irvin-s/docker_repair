FROM ubuntu:wily

# Install kerberos and unicode-data dependencies
RUN apt-get install --yes libkrb5-dev
RUN apt-get install --yes unicode-data

# Install git
RUN apt-get install --yes git

# Install node
RUN apt-get install --yes curl
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -
RUN apt-get install --yes nodejs
RUN node -v
RUN npm -v

# Create app directory
RUN mkdir -p /opt/app
WORKDIR /opt/app

# Bundle app source
COPY . /opt/app
RUN chmod 755 start.sh

# Install app dependencies
RUN npm install

EXPOSE 3000
ENTRYPOINT [ "/opt/app/start.sh" ]
