FROM microsoft/aspnetcore:2.0
ARG source
WORKDIR /app
EXPOSE 5003
COPY ${source:-obj/Docker/publish} .
ENTRYPOINT ["dotnet", "Projects.api.dll"]
