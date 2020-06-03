FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 50365
EXPOSE 44395

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["FiveRingsDb/FiveRingsDb.csproj", "FiveRingsDb/"]
WORKDIR /src/FiveRingsDb
RUN dotnet build "FiveRingsDb.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "FiveRingsDb.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "FiveRingsDb.dll"]