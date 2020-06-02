FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /Sln

COPY *.sln .
COPY Decoder/*.*sproj ./Decoder/
COPY KiotlogDBF/*.sln ./KiotlogDBF/
COPY KiotlogDBF/KiotlogDBF/*.*sproj ./KiotlogDBF/KiotlogDBF/
COPY HttpReceiver/*.*sproj ./HttpReceiver/
COPY KlsnReceiver/*.*sproj ./KlsnReceiver/
COPY libsodium-core/*.sln ./libsodium-core/
COPY libsodium-core/src/Sodium.Core/*.*sproj ./libsodium-core/src/Sodium.Core/
RUN dotnet restore

COPY . .
RUN dotnet build
RUN set -ef \
    && apt update \
    && apt install -y --no-install-recommends \
        libicu57 \
        libcurl3 \
        libunwind8 \
        libssl1.0 \
    && rm -rf /var/lib/apt/lists/*
#######################################################
# WARINING!
# Remeber to set PROJECT in runtime image section, too.
ARG PROJECT=Decoder
#######################################################
# RUN dotnet publish -c Release -r linux-x64 -o out /p:ShowLinkerSizeComparison=true
WORKDIR /Sln/${PROJECT}
RUN dotnet add package ILLink.Tasks -v 0.1.5-preview-1461378 -s https://dotnet.myget.org/F/dotnet-core/api/v3/index.json
RUN dotnet publish -c Release -r linux-x64 -o out /p:LinkDuringPublish=true /p:ShowLinkerSizeComparison=true

# build runtime image
FROM microsoft/dotnet:2.1-runtime-deps AS runtime
#FROM debian:stretch-slim


WORKDIR /App

RUN set -ef \
    && apt update \
    && apt install -y --no-install-recommends \
        libicu57 \
        libcurl3 \
        libunwind8 \
        libssl1.0 \
    && rm -rf /var/lib/apt/lists/*

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

#######################################################
# WARINING!
# Set PROJECT here, too.
ARG PROJECT=Decoder
#######################################################
COPY --from=build-env /Sln/${PROJECT}/out ./
ENTRYPOINT ["/App/Decoder"]
