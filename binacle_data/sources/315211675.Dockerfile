ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/TypeEdgeModule2/TypeEdgeModule2.csproj Modules/TypeEdgeModule2/
COPY TypeEdgeApplication.Shared/TypeEdgeApplication.Shared.csproj TypeEdgeApplication.Shared/
RUN dotnet restore Modules/TypeEdgeModule2/TypeEdgeModule2.csproj
COPY . .
WORKDIR /src/Modules/TypeEdgeModule2
RUN dotnet build TypeEdgeModule2.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish TypeEdgeModule2.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TypeEdgeModule2.dll"]
