# Image 1: Begin with nightly SDK image that contains a build of the solution
FROM jonmcquade/dotnetcore-runtime-sdk-node-python:dotnetcore-asp AS build
ARG aspenv="Production"
ENV ASPNETCORE_ENVIRONMENT $aspenv 
ARG runtime="Release"
ENV RUNTIME $runtime
ARG verbosity="detailed"
ENV VERBOSITY $verbosity
ARG serverUrls="http://*:$PORT;http://*:$SSL_PORT"
ENV ASPNETCORE_URLS $serverUrls
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true
WORKDIR /src
COPY ./src .
RUN echo '.NET SDK Version:' && dotnet --version \
## Targeting Alpine, output to /app
## This cam take a long time to package files together 
RUN echo -e "\n\n\nBuilding to /app ...\n\n\n" \
        && dotnet build -c $RUNTIME -r alpine.3.6-x64 -v $VERBOSITY -o /app \
        && echo -e "\n\n\nContents of /app ...\n\n\n" && cd /app && ls -l
    
# Image 2: Publish the built solution with self-contained dependencies to an output dir 
FROM build AS publish
ARG aspenv="Production"
ENV ASPNETCORE_ENVIRONMENT $aspenv 
ARG runtime="Release"
ENV RUNTIME $runtime
ARG verbosity="detailed"
ENV VERBOSITY $verbosity
COPY ./README.md /
## Publishing will build from source and run Webpack on dist folder assets
RUN echo -e "\n\n\n...Publishing to /app/dist ...\n\n\n" \
    && dotnet publish --self-contained -c $RUNTIME -r alpine.3.6-x64 -v $VERBOSITY -o /app/dist

# Image 3: Alpine .Net Core Runtime 2.1.0 
## Implementing:
### ASP.NET Core 2.1.0-preview 
FROM microsoft/dotnet:2.1.0-preview1-runtime-deps-alpine as base
ARG aspenv="Production"
ENV ASPNETCORE_ENVIRONMENT $aspenv
COPY ./src/entrypoint /
RUN apk add --update icu-libs libuv nodejs nodejs-npm  \
    && ln -s /usr/lib/libuv.so.1 /usr/lib/libuv.so
WORKDIR /dotnetcorespa
COPY ./src/Properties ./Properties
COPY ./README.md /
COPY ./src/tpl ./tpl
COPY ./src/App_Data ./App_Data
COPY --from=publish /app/dist .

# Image 4: Establish runtime env vars, expose ports, set CMD to entrypoint shell
## entrypoint uses .tpl files to rewrite host and port rules, then 
##   either execute `dotnet run` for (:dev) or the self-contained app (:prod)
FROM base AS final
ARG aspenv="Production"
ENV ASPNETCORE_ENVIRONMENT $aspenv
ARG port="3000"
ENV PORT $port
ARG sslPort="3001"
ENV SSL_PORT $sslPort
ENV DOTNET_SDK_VERSION 2.1.300-preview1-008174
ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT false
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ARG serverUrls="http://*:$PORT;https://*:$SSL_PORT"
ENV ASPNETCORE_URLS $serverUrls
EXPOSE 3000 3001 $port $sslPort
CMD /dotnetcorespa/FlightSearch