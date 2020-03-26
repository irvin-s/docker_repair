ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/Orchestrator/Orchestrator.csproj Modules/Orchestrator/
COPY Thermostat.Shared/Thermostat.Shared.csproj Thermostat.Shared/
RUN dotnet restore Modules/Orchestrator/Orchestrator.csproj
COPY . . 
WORKDIR /src/Modules/Orchestrator
RUN dotnet build Orchestrator.csproj -c Release -o /app
  
FROM build AS publish
RUN dotnet publish Orchestrator.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Orchestrator.dll"]
 