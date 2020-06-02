FROM microsoft/aspnetcore:1.0.1
ARG source=publish
WORKDIR /app
ENV ASPNETCORE_URLS http://*:80
EXPOSE 80
COPY $source .
ENTRYPOINT dotnet superhero-api.dll