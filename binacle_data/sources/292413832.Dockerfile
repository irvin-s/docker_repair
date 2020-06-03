FROM microsoft/dotnet:2.1-sdk-alpine

WORKDIR /src/app

RUN addgroup -S projects && adduser -S projects -G projects

COPY . .

RUN chown -R projects:projects /src/app

USER projects

RUN dotnet build

ENTRYPOINT ["/bin/sh"]
