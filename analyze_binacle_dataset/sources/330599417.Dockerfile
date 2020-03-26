FROM microsoft/dotnet:2.1-sdk-alpine AS build
WORKDIR /app

RUN apk add --update --no-cache bash

# copy csproj and restore as distinct layers
COPY *.sln .
COPY Decoder/*.*sproj ./Decoder/
COPY KiotlogDBF/*.sln ./KiotlogDBF/
COPY KiotlogDBF/KiotlogDBF/*.*sproj ./KiotlogDBF/KiotlogDBF/
COPY HttpReceiver/*.*sproj ./HttpReceiver/
COPY KlsnReceiver/*.*sproj ./KlsnReceiver/
COPY libsodium-core/*.sln ./libsodium-core/
COPY libsodium-core/src/Sodium.Core/*.*sproj ./libsodium-core/src/Sodium.Core/
RUN dotnet restore

# copy everything else and build app
COPY . .
WORKDIR /app/Decoder
RUN dotnet build

FROM build AS publish
WORKDIR /app/Decoder
RUN dotnet publish -c Release -o out

FROM microsoft/dotnet:2.1-runtime-alpine AS runtime

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
RUN apk add --no-cache icu-libs

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

WORKDIR /app
COPY --from=publish /app/Decoder/out ./
ENTRYPOINT ["dotnet", "Decoder.dll"]
