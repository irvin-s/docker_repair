FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src

RUN curl -sL https://deb.nodesource.com/setup_12.x |  bash -
RUN apt-get install -y nodejs

COPY ["HiShare/HiShare.csproj", "HiShare/"]
RUN dotnet restore "HiShare/HiShare.csproj"
COPY . .
WORKDIR "/src/HiShare"
RUN dotnet build "HiShare.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "HiShare.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "HiShare.dll"]
