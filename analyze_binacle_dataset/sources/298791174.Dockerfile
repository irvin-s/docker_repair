FROM microsoft/windowsservercore:latest

# This image is created and maintained by Ritesh Modi
MAINTAINER "Ritesh Modi"

# It shows the usage of VOLUME instruction
#ENTRYPOINT Powershell ping 127.0.0.1 -t
ENTRYPOINT ["Powershell","ping", "127.0.0.1", "-t"]
