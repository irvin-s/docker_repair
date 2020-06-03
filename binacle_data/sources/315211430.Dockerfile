FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 52832
EXPOSE 44331

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY Modules/VisualizationWeb/VisualizationWeb.csproj Modules/VisualizationWeb/
RUN dotnet restore Modules/VisualizationWeb/VisualizationWeb.csproj
COPY . .
WORKDIR /src/Modules/VisualizationWeb
RUN dotnet build VisualizationWeb.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish VisualizationWeb.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "VisualizationWeb.dll"]
