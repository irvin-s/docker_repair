ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/TemperatureSensor/TemperatureSensor.csproj Modules/TemperatureSensor/
COPY Thermostat.Shared/Thermostat.Shared.csproj Thermostat.Shared/

COPY ./.env Thermostat.Emulator/
COPY NuGet.Config ./

RUN dotnet restore Modules/TemperatureSensor/TemperatureSensor.csproj
COPY . .
WORKDIR /src/Modules/TemperatureSensor
RUN dotnet build TemperatureSensor.csproj -c Release -o /app
 
FROM build AS publish
RUN dotnet publish TemperatureSensor.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TemperatureSensor.dll"]
