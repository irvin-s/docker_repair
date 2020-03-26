FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY Evelyn.Server.Host/Evelyn.Server.Host.csproj Evelyn.Server.Host/
COPY Evelyn.Management.Api.Rest/Evelyn.Management.Api.Rest.csproj Evelyn.Management.Api.Rest/
COPY Evelyn.Core/Evelyn.Core.csproj Evelyn.Core/
COPY Evelyn.Storage.EventStore/Evelyn.Storage.EventStore.csproj Evelyn.Storage.EventStore/
RUN dotnet restore Evelyn.Server.Host/Evelyn.Server.Host.csproj
COPY . .
WORKDIR /src/Evelyn.Server.Host
RUN dotnet build Evelyn.Server.Host.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Evelyn.Server.Host.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Evelyn.Server.Host.dll"]
