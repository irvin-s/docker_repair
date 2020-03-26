FROM microsoft/dotnet:2.1-aspnetcore-runtime
ENTRYPOINT ["dotnet", "ApiRunner.dll"]
ARG source=.
WORKDIR /app
COPY $source .

EXPOSE 5000/tcp

ENV ASPNETCORE_URLS http://*:5000
