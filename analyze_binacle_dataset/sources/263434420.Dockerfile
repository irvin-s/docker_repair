FROM ubuntu:18.04

RUN apt-get update
RUN apt-get -y install wget apt-transport-https software-properties-common

# Install .NET sdk and runtime
# https://www.microsoft.com/net/download/linux-package-manager/ubuntu18-04/sdk-current
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN add-apt-repository universe
RUN apt-get update
RUN apt-get install -y dotnet-sdk-2.1 aspnetcore-runtime-2.1
