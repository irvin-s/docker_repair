FROM microsoft/dotnet:2.1-sdk AS build-env

RUN set -ex \
    && apt update \
    && apt install -y --no-install-recommends \
        qemu-user-static

WORKDIR /Sln

COPY . .
RUN dotnet restore

WORKDIR /Sln/Decoder
RUN dotnet publish -c Release -r linux-arm -o out

# build runtime image
FROM arm32v7/debian:stretch-slim

COPY --from=build-env /usr/bin/qemu-arm-static /usr/bin/qemu-arm-static

WORKDIR /App

RUN set -ef \
    && apt update \
    && apt install -y --no-install-recommends \
        libicu57 libcurl3 libunwind8 libssl1.0 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build-env /Sln/Decoder/out ./

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENTRYPOINT ["/App/Decoder"]
