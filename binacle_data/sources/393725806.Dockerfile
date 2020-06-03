FROM microsoft/dotnet:1.0.0-core

WORKDIR /app

COPY /bin/Release/netcoreapp1.0 /app

ENTRYPOINT dotnet HelloWorldConsole.dll