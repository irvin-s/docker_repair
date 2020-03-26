FROM mono

ENV rootDir /usr/library.webapi

RUN mkdir $rootDir
ADD . $rootDir
WORKDIR ${rootDir}

RUN apt-get update
RUN apt-get install nunit-console
RUN nuget restore
RUN xbuild

ENTRYPOINT [ "nunit-console", "/usr/library.webapi/Library.WebApi.UnitTests/bin/Debug/Library.WebApi.UnitTests.dll" ]
