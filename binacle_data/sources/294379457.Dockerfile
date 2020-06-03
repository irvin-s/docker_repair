FROM microsoft/dotnet:2.2-runtime AS base
WORKDIR /app

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY Evelyn.Client.Host/Evelyn.Client.Host.csproj Evelyn.Client.Host/
COPY Evelyn.Client.Rest/Evelyn.Client.Rest.csproj Evelyn.Client.Rest/
COPY Evelyn.Client/Evelyn.Client.csproj Evelyn.Client/
RUN dotnet restore Evelyn.Client.Host/Evelyn.Client.Host.csproj
COPY . .
WORKDIR /src/Evelyn.Client.Host
RUN dotnet build Evelyn.Client.Host.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Evelyn.Client.Host.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Evelyn.Client.Host.dll"]
