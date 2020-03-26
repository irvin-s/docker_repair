FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app

# Default Environment
ENV ASPNETCORE_ENVIRONMENT="Development"

# Args
ARG distFolder=src/Camaleao.Api/bin/Release/netcoreapp2.0
ARG apiProtocol=http
ARG apiPort=5000
ARG appFile=Camaleao.Api.dll

# Copy files to /app
RUN ls
COPY ${distFolder} /app
 
# Expose port for the Web API traffic
ENV ASPNETCORE_URLS ${apiProtocol}://+:${apiPort}
EXPOSE ${apiPort}

# Run application
WORKDIR /app
RUN ls
ENV appFile=$appFile
ENTRYPOINT dotnet $appFile
