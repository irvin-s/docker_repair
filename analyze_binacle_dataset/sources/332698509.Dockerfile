FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS builder
WORKDIR /app
COPY ./app.csproj ./
RUN dotnet restore
COPY . .
RUN dotnet publish -c Release

FROM mcr.microsoft.com/dotnet/core/runtime:2.2
COPY --from=builder /app/bin/Release/netcoreapp2.1/publish/ /app/
CMD dotnet /app/app.dll
