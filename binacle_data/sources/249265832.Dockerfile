FROM microsoft/dotnet:1.0-sdk

COPY . /app

WORKDIR /app

RUN ["dotnet", "restore"]

RUN ["dotnet", "build"]

EXPOSE 5000/tcp

WORKDIR /app/src/Sandbox.Server.Http

ENTRYPOINT ["dotnet", "run", "--server.urls", "http://0.0.0.0:5000"]
