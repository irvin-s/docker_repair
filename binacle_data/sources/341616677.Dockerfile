FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS sdk-with-node
ENV NODE_VERSION 8.11.1
ENV NODE_DOWNLOAD_SHA 0e20787e2eda4cc31336d8327556ebc7417e8ee0a6ba0de96a09b0ec2b841f60
RUN curl -SL "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz" --output nodejs.tar.gz \
    && echo "$NODE_DOWNLOAD_SHA nodejs.tar.gz" | sha256sum -c - \
    && tar -xzf "nodejs.tar.gz" -C /usr/local --strip-components=1 \
    && rm nodejs.tar.gz \
    && ln -s /usr/local/bin/node /usr/local/bin/nodejs

FROM sdk-with-node AS updated-npm
RUN npm i -g npm

FROM updated-npm AS build
WORKDIR /src
COPY BeatPulse.sln ./
COPY global.json ./
COPY Directory.Build.props ./
COPY ./build/dependencies.props ./build/
COPY ./src/BeatPulse.UI/build ./src/BeatPulse.UI/build
COPY ./src/BeatPulse.UI/assets ./src/BeatPulse.UI/assets
COPY ./src/BeatPulse.UI/client ./src/BeatPulse.UI/client

COPY ./docker-images/BeatPulseUI-Image/BeatPulseUI-Image.csproj docker-images/BeatPulseUI-Image/
COPY . .
WORKDIR /src/docker-images/BeatPulseUI-Image
RUN dotnet restore -nowarn:msb3202,nu1503

RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "BeatPulseUI-Image.dll"]
