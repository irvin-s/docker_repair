FROM microsoft/dotnet:2.0.3-sdk AS build-env

COPY . /app
WORKDIR /app
RUN dotnet publish -c Release -o /app/out

# Build runtime image
FROM microsoft/dotnet:2.0.3-runtime
WORKDIR /app

COPY --from=build-env /app/out ./

ENTRYPOINT ["dotnet", "WorkerService.dll"]
