FROM microsoft/dotnet:1.0-runtime
WORKDIR /app
COPY out .
ENTRYPOINT ["dotnet", "dotnet-catalog.dll"]