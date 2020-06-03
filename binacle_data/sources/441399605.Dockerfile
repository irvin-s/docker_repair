FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["Order.API/Order.API.csproj", "Order.API/"]
RUN dotnet restore "Order.API/Order.API.csproj"
COPY . .
WORKDIR "/src/Order.API"
RUN dotnet build "Order.API.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "Order.API.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Order.API.dll"]