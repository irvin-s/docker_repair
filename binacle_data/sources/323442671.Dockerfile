FROM microsoft/dotnet:2.1-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 9041

FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /src
COPY src/Microsoft.Azure.IIoT.Services.OpcUa.Twin/src/Microsoft.Azure.IIoT.Services.OpcUa.Twin.csproj src/Microsoft.Azure.IIoT.Services.OpcUa.Twin/src/
COPY NuGet.Config NuGet.Config
COPY *.props /
RUN dotnet restore --configfile NuGet.Config -nowarn:msb3202,nu1503 src/Microsoft.Azure.IIoT.Services.OpcUa.Twin/src/Microsoft.Azure.IIoT.Services.OpcUa.Twin.csproj
COPY . .
WORKDIR /src/src/Microsoft.Azure.IIoT.Services.OpcUa.Twin/src
RUN dotnet build Microsoft.Azure.IIoT.Services.OpcUa.Twin.csproj -c Release -o /app

FROM build AS publish
RUN dotnet publish Microsoft.Azure.IIoT.Services.OpcUa.Twin.csproj -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "Microsoft.Azure.IIoT.Services.OpcUa.Twin.dll"]
