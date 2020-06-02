FROM bookatable/node-linux:latest  
MAINTAINER Bookatable - Mobile <mobile.devs@bookatable.com>  
  
#------------------------------------------------  
# set environment variables  
# PARSE_DASHBOARD_CONFIG_ENVIRONMENT supports: dev, uat, prod  
ENV PARSE_DASHBOARD_CONFIG_ENVIRONMENT=setYourEnvironment  
  
#------------------------------------------------  
WORKDIR /src  
  
ADD . /src  
  
RUN cd /src \  
&& npm install -g webpack \  
&& npm install \  
&& npm run build \  
&& npm cache clear \  
&& rm -rf ~/.npm \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV NODE_ENV=production  
ENV WEB_SERVER_PORT=80  
ENV PARSE_DASHBOARD_ALLOW_INSECURE_HTTP=0  
EXPOSE $WEB_SERVER_PORT  
  
ENTRYPOINT ["sh", "/src/bin/start_parse_dashboard.sh"]  

