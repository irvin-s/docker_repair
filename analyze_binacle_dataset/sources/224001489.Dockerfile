FROM microsoft/dotnet:1.0-nanoserver-runtime
WORKDIR /app
COPY out .
ENTRYPOINT ["dotnet", "dotnet-catalog.dll"]