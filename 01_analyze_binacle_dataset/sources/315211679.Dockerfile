ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base

# Add an unprivileged user account for running Edge Hub
RUN useradd -ms /bin/bash edgehubuser
ENV EdgeHubUser=edgehubuser

ARG EXE_DIR=.
ENV SSL_CERTIFICATE_PATH=/app/certs
ENV SSL_CERTIFICATE_NAME=mqtt-server.pfx

# Install snappy and set up symlinks that are absent from the base image
# Required by RocksDb
RUN apt-get update && \
    apt-get install -y libsnappy1v5 libcap2-bin && \
    ln -s /lib/x86_64-linux-gnu/libdl.so.2 /usr/lib/x86_64-linux-gnu/libdl.so && \
    ln -s /lib/x86_64-linux-gnu/libc.so.6 /usr/lib/x86_64-linux-gnu/libc.so && \
    rm -rf /var/lib/apt/lists/*

# add the CAP_NET_BIND_SERVICE capability to the dotnet binary because
# we are starting edge hub as a non-root user
RUN setcap 'cap_net_bind_service=+ep' /usr/share/dotnet/dotnet

WORKDIR /app

COPY $EXE_DIR/ ./

# Expose MQTT and HTTPS ports 
EXPOSE 8883/tcp
EXPOSE 443/tcp

 
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY TypeEdgeApplication.Emulator/TypeEdgeApplication.Emulator.csproj TypeEdgeApplication.Emulator/
COPY TypeEdgeApplication.Shared/TypeEdgeApplication.Shared.csproj TypeEdgeApplication.Shared/
COPY Modules/TypeEdgeModule2/TypeEdgeModule2.csproj Modules/TypeEdgeModule2/
COPY Modules/TypeEdgeModule1/TypeEdgeModule1.csproj Modules/TypeEdgeModule1/

COPY ./.env Thermostat.Emulator/
COPY NuGet.Config ./
RUN dotnet restore TypeEdgeApplication.Emulator/TypeEdgeApplication.Emulator.csproj
COPY . .
WORKDIR /src/TypeEdgeApplication.Emulator
RUN dotnet build TypeEdgeApplication.Emulator.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish TypeEdgeApplication.Emulator.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TypeEdgeApplication.Emulator.dll"]
