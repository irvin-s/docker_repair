FROM microsoft/dotnet:latest

COPY . /app
WORKDIR /app
RUN ["dotnet", "restore"]

EXPOSE 5000
ENTRYPOINT ["dotnet", "run"]
