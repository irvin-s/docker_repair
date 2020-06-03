FROM docker-hub.2gis.ru/microsoft/dotnet:2.0.9-runtime-deps

WORKDIR /app

CMD ["bash", "-c"]

COPY . .
