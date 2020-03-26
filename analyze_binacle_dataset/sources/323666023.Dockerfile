FROM microsoft/aspnetcore-build
EXPOSE 80
COPY . /app
WORKDIR /app
RUN dotnet build -c Release
RUN dotnet publish -c Release -o /publish
WORKDIR /app/publish
ENTRYPOINT ["dotnet", "LindDotNetCore.Api.dll"]
