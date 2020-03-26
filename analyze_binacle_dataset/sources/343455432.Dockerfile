FROM microsoft/aspnet:vs-1.0.0-beta4

COPY . /app
WORKDIR /app


RUN apt-get update -y && apt-get install --no-install-recommends -y -q \
    curl \
    python \
    build-essential \
    git \
    ca-certificates

RUN mkdir /nodejs && \
    curl http://nodejs.org/dist/v0.10.33/node-v0.10.33-linux-x64.tar.gz | \
    tar xvzf - -C /nodejs --strip-components=1

ENV PATH $PATH:/nodejs/bin

RUN npm install -g grunt-cli bower

RUN ["dnu", "restore"]
RUN ["npm", "install", "."]
RUN ["grunt", "default"]

EXPOSE 5001

ENTRYPOINT ["dnx", "./", "kestrel"]