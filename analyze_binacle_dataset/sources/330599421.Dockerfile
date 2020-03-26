FROM debian:stretch-slim AS build-env

RUN set -ex \
	&& apt update \
	&& apt install --no-install-recommends --assume-yes \
		ca-certificates curl \
        	libicu57 libunwind8 \
	&& curl -fsSLO https://download.microsoft.com/download/4/0/9/40920432-3302-47a8-b13c-bbc4848ad114/dotnet-sdk-2.1.302-linux-arm64.tar.gz \
	&& mkdir -p /opt/dotnet \
	&& tar xf dotnet-sdk-2.1.302-linux-arm64.tar.gz -C /opt/dotnet

ENV DOTNET_CLI_TELEMETRY_OPTOUT 1
ENV PATH $PATH:/opt/dotnet
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

WORKDIR /Sln

#######################################################
# WARINING!
# Remeber to set PROJECT in runtime image section, too.
ARG PROJECT=Decoder
#######################################################

COPY . .
RUN dotnet restore

WORKDIR /Sln/${PROJECT}
RUN dotnet publish -c Release -r linux-arm64 -o out 

# build runtime image
FROM debian:stretch-slim

#######################################################
# WARINING!
# Set PROJECT here, too.
ARG PROJECT=Decoder
#######################################################

WORKDIR /App

RUN set -ef \
    && apt update \
    && apt install -y --no-install-recommends \
        libicu57 libcurl3 libunwind8 libssl1.0 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build-env /Sln/${PROJECT}/out ./

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENTRYPOINT ["/App/Decoder"]
