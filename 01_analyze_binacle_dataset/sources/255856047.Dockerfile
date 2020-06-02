FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY published ./
ENV ASPNETCORE_URLS http://+:80
EXPOSE 80
ENTRYPOINT ["dotnet", "webapp2.0.dll"]
