FROM jonmcquade/dotnetcore-runtime-sdk-node-python:dotnetcore-asp
WORKDIR /dotnetcorespa
ARG aspenv="Development"
ENV ASPNETCORE_ENVIRONMENT $aspenv\
ARG port="8080"
ENV PORT $port
ARG sslPort="8443"
ENV SSL_PORT $sslPort
ARG runtime="Release"
ENV RUNTIME $runtime
ENV DOTNET_SKIP_FIRST_TIME_EXPERIENCE true
COPY ./entrypoint /
COPY ./ .
RUN cd /dotnetcorespa && npm install \
  && dotnet restore 
ARG serverUrls="http://*:$PORT;https://*:$SSL_PORT"
ENV ASPNETCORE_URLS $serverUrls
EXPOSE 9229 8080 8443 $port $ssl_port
CMD sh /entrypoint

