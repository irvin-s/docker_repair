# escape=`

## Git

FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS gitinstaller
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GIT_VERSION="2.17.1"
ARG GIT_RELEASE_NUMBER="2"
ARG GIT_DOWNLOAD_SHA256="52e611a411cd58eaaab8218bb917cb4410b0c5733f234be6e581c6a9821b30ea"

RUN Write-Host "Downloading Git version: $($env:GIT_VERSION), release: $($env:GIT_RELEASE_NUMBER)"; `
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.$($env:GIT_RELEASE_NUMBER)/MinGit-$($env:GIT_VERSION).$($env:GIT_RELEASE_NUMBER)-64-bit.zip"

RUN if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
    Expand-Archive -Path git.zip -DestinationPath C:\git; Remove-Item git.zip -Force

## Docker

FROM mcr.microsoft.com/windows/servercore:ltsc2019 AS dockercli
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

## Runtime

FROM dtr.olly.dtcntr.net/admin/openjdk:ltsc2019
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG VERSION="3.27"
ARG DOCKER_PATH="C:\Program Files\docker"
ARG GIT_VERSION="2.17.1"

ENV GIT_VERSION=${GIT_VERSION} `
    GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;" `
    DOCKER_PATH=${DOCKER_PATH}

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -Uri "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/$($env:VERSION)/remoting-$($env:VERSION).jar" -OutFile 'slave.jar';

COPY --from=dockercli ${DOCKER_PATH} ${DOCKER_PATH}

WORKDIR "C:\git"
COPY --from=gitinstaller "C:\git" .

RUN $env:PATH = $env:DOCKER_PATH + ';' + $env:GIT_PATH + ';' + $env:PATH; [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

WORKDIR "C:\\"

ENTRYPOINT ["C:\\ojdkbuild\\bin\\java.exe", "-Dorg.jenkinsci.remoting.engine.JnlpProtocol3.disabled=true", "-cp", ".\\slave.jar", "hudson.remoting.jnlp.Main", "-headless"]
