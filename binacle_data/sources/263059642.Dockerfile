#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG DOCKER_PATH="C:\Program Files\docker"
ARG DOCKER_VERSION="18-09-0"
ENV DOCKER_PATH ${DOCKER_PATH} 

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest "https://dockermsft.blob.core.windows.net/dockercontainer/docker-$($env:DOCKER_VERSION).zip" -OutFile 'docker.zip';

RUN Expand-Archive -Path docker.zip -DestinationPath $env:DOCKER_PATH -force; `
    mv $env:DOCKER_PATH\docker\* $env:DOCKER_PATH; `
    Remove-Item docker.zip -Force; `
    Remove-Item $env:DOCKER_PATH\docker; `
    Remove-Item $env:DOCKER_PATH\dockerd.exe;

RUN $env:PATH = $env:DOCKER_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)
