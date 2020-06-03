FROM microsoft/dotnet:1.1.0-sdk-projectjson

ADD . /app
WORKDIR /app
RUN ["dotnet", "restore"]

EXPOSE 8080
WORKDIR /app/src/WebApplication1/
ENTRYPOINT ["dotnet", "run", "-p", "project.json"]