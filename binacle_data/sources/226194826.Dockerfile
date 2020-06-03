FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY ./out .

ENTRYPOINT ["dotnet", "docker-tutorial.dll"]
