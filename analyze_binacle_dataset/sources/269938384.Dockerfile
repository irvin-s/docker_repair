FROM microsoft/dotnet:2.0.0-runtime
WORKDIR /dotnetapp
COPY ./bin/Docker .
ENV ASPNETCORE_ENVIRONMENT production
ENTRYPOINT dotnet Fibon.Api.dll --urls "http://*:5000"