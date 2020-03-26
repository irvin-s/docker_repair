FROM microsoft/dotnet:2.2-aspnetcore-runtime AS deploy
WORKDIR /app
EXPOSE 80
COPY "bin/Debug/netcoreapp2.2/publish/" "./"