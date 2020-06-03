FROM mono

EXPOSE 5000

RUN apt-get update
RUN apt-get install mono-4.0-service
RUN mkdir /usr/library.webapi
ADD . /usr/library.webapi
WORKDIR /usr/library.webapi

RUN nuget restore
RUN xbuild

CMD [ "mono-service", "Library.WebApi/bin/Debug/Library.WebApi.exe" ]
