FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /Sln

# COPY nuget.config ./
# COPY *.*sproj ./
COPY . .
RUN dotnet restore

# copy everything else and build
# COPY src ./src
# RUN dotnet publish -c Release -r linux-x64 -o out /p:ShowLinkerSizeComparison=true
WORKDIR /Sln/HttpReceiver
RUN dotnet publish -c Release -r linux-x64 -o out /p:LinkDuringPublish=false /p:ShowLinkerSizeComparison=true

# build runtime image
FROM debian:stretch-slim
WORKDIR /App
RUN apt update \
    && apt install -y --no-install-recommends \
        libicu57 libcurl3 libunwind8 libssl1.0 \
    && rm -rf /var/lib/apt/lists/*
COPY --from=build-env /Sln/HttpReceiver/out ./
ENTRYPOINT ["/App/HttpReceiver" ]
