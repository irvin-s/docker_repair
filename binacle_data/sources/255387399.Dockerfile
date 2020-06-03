FROM docker-hub.2gis.ru/microsoft/dotnet:2.1.7-runtime-deps-alpine3.7
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS http://*:5000

ENTRYPOINT ["./VStore.Renderer"]

COPY . .