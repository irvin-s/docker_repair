FROM microsoft/aspnet

RUN powershell -Command Install-WindowsFeature -Name Web-WebSockets

COPY ./Output/ /inetpub/wwwroot


