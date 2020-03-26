FROM microsoft/dotnet:2.1-sdk
ENV NUGET_XMLDOC_MODE skip
WORKDIR /vsdbg
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       unzip \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sSL https://aka.ms/getvsdbgsh | bash /dev/stdin -v latest -l /vsdbg


COPY ./src/ /build/src
COPY ./Solution.Context.sln /build

WORKDIR /build
RUN dotnet restore

RUN dotnet publish \
    /build/src/Solution.Context.WebApi/Solution.Context.WebApi.csproj \
    --no-restore \
    --configuration Debug \
    --output out

EXPOSE 80/tcp

# Kick off a container just to wait debugger to attach and run the app
ENTRYPOINT ["/bin/bash", "-c", "sleep infinity"]
