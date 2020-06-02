FROM microsoft/aspnetcore-build:2.0
WORKDIR /app

COPY *.csproj .
RUN dotnet restore

COPY . .
RUN dotnet publish --output /out/ --configuration Release
