FROM microsoft/aspnetcore-build:2.0.3 AS build-env

COPY . /app
WORKDIR /app
RUN dotnet publish -c Release -o /app/out

# Build runtime image
FROM microsoft/aspnetcore:2.0.3
WORKDIR /app

COPY --from=build-env /app/out ./
EXPOSE 4000

ENTRYPOINT ["dotnet", "WebService.dll"]
