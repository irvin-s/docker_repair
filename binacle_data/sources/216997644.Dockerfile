FROM microsoft/dotnet:1.0.0-preview2-sdk

RUN apt-get update \
    && apt-get install -y nodejs npm \
    && ln -s /usr/bin/nodejs /usr/bin/node \
    && npm i -g bower

ADD WidgetGallery NuGet.config /WidgetGallery/
WORKDIR /WidgetGallery

RUN bower install --allow-root \
    && dotnet restore \
    && dotnet build

EXPOSE 5555

CMD dotnet run
