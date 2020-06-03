FROM microsoft/dotnet:1.0.0-preview2-sdk
ARG hostip
RUN rm /etc/apt/sources.list.d/llvm.list
RUN apt-get -qq update && apt-get -qqy --no-install-recommends install \
    git \
    unzip

RUN curl -sL https://deb.nodesource.com/setup_6.x |  bash -
RUN apt-get install -y nodejs

RUN mkdir -p /AureliaAspNetApp

COPY . /AureliaAspNetApp
WORKDIR /AureliaAspNetApp
RUN ["dotnet", "restore"]

RUN ["npm","install"]
#the docker compose environment var is injected here in the SPA javascript file authConfig.js
#for magic see following line

RUN sed -i s/docker-provided-apiServerBaseAddress/$hostip/g ./src/authConfig.js

RUN ["npm", "run","build"]


EXPOSE 49849/tcp
ENTRYPOINT ["dotnet", "run"]
