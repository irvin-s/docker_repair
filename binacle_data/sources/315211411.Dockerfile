ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/ModelTraining/ModelTraining.csproj Modules/ModelTraining/
COPY Thermostat.Shared/Thermostat.Shared.csproj Thermostat.Shared/
RUN dotnet restore Modules/ModelTraining/ModelTraining.csproj
COPY . . 
WORKDIR /src/Modules/ModelTraining
RUN dotnet build ModelTraining.csproj -c Release -o /app
  
FROM build AS publish
RUN dotnet publish ModelTraining.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "ModelTraining.dll"]
 