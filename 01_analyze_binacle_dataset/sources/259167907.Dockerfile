FROM microsoft/dotnet:1.0.0-preview2-nanoserver-sdk

MAINTAINER Julien Corioland, Microsoft (@jcorioland)

WORKDIR /app
ENTRYPOINT ["dotnet", "run"]

ENV ASPNETCORE_URLS http://0.0.0.0:5001
EXPOSE 5001

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

# Temporary workaround for Windows DNS client weirdness
RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

COPY project.json ./
RUN ["dotnet", "restore"]

COPY . /app
RUN ["dotnet", "build"]