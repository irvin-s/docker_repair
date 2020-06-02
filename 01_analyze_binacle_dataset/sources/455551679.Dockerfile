FROM microsoft/dotnet:2.2-runtime

WORKDIR /app
COPY bin/publish/ /app

ENTRYPOINT [ "dotnet", "redis.dll" ]
