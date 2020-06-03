#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM arssolvendi.azurecr.io/dotnet:2.2-runtime-servercore-1809 AS base
#FROM microsoft/dotnet:2.2-aspnetcore-runtime-nanoserver-1809 AS base
WORKDIR /app
EXPOSE 80
USER ContainerAdministrator
RUN powershell -Command \
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco feature disable --name showDownloadProgress; \
    choco install -y docker-cli;

FROM microsoft/dotnet:2.2-sdk-nanoserver-1809 AS build
WORKDIR /src
COPY ["api.csproj", "api/"]
RUN dotnet restore "api/api.csproj"
WORKDIR /src/api
COPY . .
RUN dotnet build "api.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "api.csproj" -c Release -o /app

FROM base AS final

USER ContainerAdministrator
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "api.dll"]
