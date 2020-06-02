ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/AnomalyDetection/AnomalyDetection.csproj Modules/AnomalyDetection/
COPY Thermostat.Shared/Thermostat.Shared.csproj Thermostat.Shared/
RUN dotnet restore Modules/AnomalyDetection/AnomalyDetection.csproj
COPY . . 
WORKDIR /src/Modules/AnomalyDetection
RUN dotnet build AnomalyDetection.csproj -c Release -o /app
  
FROM build AS publish
RUN dotnet publish AnomalyDetection.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AnomalyDetection.dll"]
 