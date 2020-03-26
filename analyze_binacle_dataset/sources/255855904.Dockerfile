FROM microsoft/aspnetcore:1.1
WORKDIR /app
COPY published ./
ENV ASPNETCORE_URLS http://+:9000
EXPOSE 9000
ENTRYPOINT ["dotnet", "mywebapi.dll"]