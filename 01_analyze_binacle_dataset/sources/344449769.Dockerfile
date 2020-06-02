FROM microsoft/dotnet:2.0-sdk
MAINTAINER you<info@ez-design.net>

RUN mkdir /Radikool6/ && \
    mkdir /Radikool6/data && \
    apt-get update && \
    apt-get install ffmpeg -y && \
    git clone https://github.com/ez-design/Radikool6.git src && \
    cd src && \
    dotnet restore && \
    dotnet publish -c release -o /Radikool6/
EXPOSE 5000
WORKDIR /Radikool6/
CMD ["dotnet", "Radikool6.dll"]