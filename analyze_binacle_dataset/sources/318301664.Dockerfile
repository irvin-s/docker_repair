FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY SqlServerAutoTuningDashboard.csproj .
RUN dotnet restore SqlServerAutoTuningDashboard.csproj
COPY . .
RUN dotnet build SqlServerAutoTuningDashboard.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish SqlServerAutoTuningDashboard.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "SqlServerAutoTuningDashboard.dll"]