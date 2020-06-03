# Stage 1
FROM microsoft/aspnetcore-build:1.0-2.0 AS builder
WORKDIR /source

COPY . .
RUN dotnet restore Matterfeed.NET.sln
RUN dotnet publish Matterfeed.NET.sln -c Release -o /publish

# Stage 2
FROM microsoft/dotnet:2.0-runtime
WORKDIR /app
COPY --from=builder /publish .
ENTRYPOINT ["dotnet", "Matterfeed.NET.dll"]
