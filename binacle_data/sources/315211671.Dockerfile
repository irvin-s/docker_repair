ARG base_tag=2.1.2-runtime-bionic
FROM microsoft/dotnet:${base_tag} AS base
WORKDIR /app

FROM microsoft/dotnet:2.1.302-sdk AS build
WORKDIR /src
COPY Modules/TypeEdgeModule1/TypeEdgeModule1.csproj Modules/TypeEdgeModule1/
COPY TypeEdgeApplication.Shared/TypeEdgeApplication.Shared.csproj TypeEdgeApplication.Shared/
RUN dotnet restore Modules/TypeEdgeModule1/TypeEdgeModule1.csproj 
COPY . .
WORKDIR /src/Modules/TypeEdgeModule1
RUN dotnet build TypeEdgeModule1.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish TypeEdgeModule1.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TypeEdgeModule1.dll"]
