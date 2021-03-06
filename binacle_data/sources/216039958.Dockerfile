# escape=`

FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1198 AS builder

WORKDIR C:\src\ProductLaunch.MessageHandlers.IndexProspect
COPY src\ProductLaunch\ProductLaunch.MessageHandlers.IndexProspect\packages.config .
RUN nuget restore packages.config -PackagesDirectory ..\packages

COPY src\ProductLaunch C:\src
RUN msbuild ProductLaunch.MessageHandlers.IndexProspect.csproj /p:OutputPath=c:\out\index-prospect\IndexProspectHandler

# app image
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

WORKDIR /index-prospect-handler
CMD .\ProductLaunch.MessageHandlers.IndexProspect.exe

ENV MESSAGE_QUEUE_URL="nats://message-queue:4222" `
    ELASTICSEARCH_URL="http://elasticsearch:9200"

COPY --from=builder C:\out\index-prospect\IndexProspectHandler .