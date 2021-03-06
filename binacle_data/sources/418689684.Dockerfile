
FROM microsoft/windowsservercore:1607 as build

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NODE_VERSION 10.11.0

RUN Invoke-WebRequest $('https://nodejs.org/dist/v{0}/node-v{0}-win-x64.zip' -f $env:NODE_VERSION) -OutFile 'node.zip' -UseBasicParsing ; \
Expand-Archive node.zip -DestinationPath C:\ ;\
Rename-Item -Path $('C:\node-v{0}-win-x64' -f $env:NODE_VERSION) -NewName 'C:\nodejs'

RUN $env:PATH = 'C:\nodejs;{0}' -f $env:PATH ; \
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENV DOTNET_SDK_VERSION 2.2.203

RUN Invoke-WebRequest -OutFile dotnet.zip https://dotnetcli.blob.core.windows.net/dotnet/Sdk/$Env:DOTNET_SDK_VERSION/dotnet-sdk-$Env:DOTNET_SDK_VERSION-win-x64.zip; \
Expand-Archive dotnet.zip -DestinationPath c:\sdk; \
Remove-Item -Force dotnet.zip

ENV ASPNETCORE_VERSION 2.2.4
RUN Invoke-WebRequest -OutFile aspnetcore.zip https://dotnetcli.blob.core.windows.net/dotnet/aspnetcore/Runtime/$Env:ASPNETCORE_VERSION/aspnetcore-runtime-$Env:ASPNETCORE_VERSION-win-x64.zip; \
Expand-Archive aspnetcore.zip -DestinationPath c:\dotnet; \
Remove-Item -Force aspnetcore.zip

RUN $env:PATH = $('c:\sdk;{0}' -f $env:PATH) ;\
[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY Rnwood.Smtp4dev/*.csproj ./Rnwood.Smtp4dev/
RUN dotnet restore Rnwood.Smtp4dev

COPY Rnwood.Smtp4dev/npm-shrinkwrap.json ./Rnwood.Smtp4dev/
COPY Rnwood.Smtp4dev/package.json ./Rnwood.Smtp4dev/
WORKDIR /app/Rnwood.Smtp4dev
RUN npm install

# copy everything else and build app

WORKDIR /app
ARG version
ENV VERSION $version
COPY . .
WORKDIR /app/Rnwood.Smtp4dev
RUN dotnet build -p:Version=$env:VERSION
RUN dotnet test -p:Version=$env:VERSION
RUN dotnet publish -c Release -o out -p:Version=$env:VERSION

FROM mcr.microsoft.com/windows/nanoserver:sac2016 as runtime
EXPOSE 80
EXPOSE 25
COPY --from=build /dotnet /dotnet

COPY --from=build /app/Rnwood.Smtp4dev/out /app

ENV ASPNETCORE_URLS=http://+:80 \
DOTNET_RUNNING_IN_CONTAINER=true

WORKDIR /dotnet
ENTRYPOINT ["dotnet", "/app/Rnwood.Smtp4dev.dll"]