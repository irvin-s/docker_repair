FROM microsoft/aspnetcore:2.0 AS base
WORKDIR /app
EXPOSE 5000

FROM microsoft/aspnetcore-build:2.0 AS build
WORKDIR /src
COPY *.sln ./
COPY IdentityServerManager.UI/IdentityServerManager.UI.csproj IdentityServerManager.UI/
RUN dotnet restore
COPY . .
WORKDIR /src/IdentityServerManager.UI
RUN dotnet build -c Release -o /app

FROM build AS publish
RUN dotnet publish -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "IdentityServerManager.UI.dll"]
