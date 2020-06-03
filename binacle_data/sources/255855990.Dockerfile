FROM microsoft/aspnetcore:2.0
WORKDIR /app
COPY published ./
ENV ASPNETCORE_URLS http://+:9000
EXPOSE 9000
ENTRYPOINT ["dotnet", "webapi2.0.dll"]
