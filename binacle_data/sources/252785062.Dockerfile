FROM mhart/alpine-node:6  
MAINTAINER Krzysztof Winiarski  
  
RUN apk add \--no-cache make gcc g++ python \  
&& addgroup strong-pm \  
&& adduser -D -G strong-pm -s /bin/sh strong-pm \  
&& chown -R strong-pm:strong-pm $(npm config get prefix)/lib/node_modules \  
&& chown -R strong-pm:strong-pm $(npm config get prefix)/bin \  
&& chown -R strong-pm:strong-pm $(npm config get prefix)/share \  
&& su -c "npm install -g strongloop" \- strong-pm \  
&& su -c "slc pm-install -b /home/strong-pm -u strong-pm" \  
&& npm cache clear \  
&& rm -rf /tmp/npm* /home/strong-pm/.npm /home/strong-pm/.node-gyp \  
&& apk del make gcc g++ python --purge  
  
# Set up some semblance of an environment  
WORKDIR /home/strong-pm  
  
# Run as non-privileged user inside container  
USER strong-pm  
  
# Expose strong-pm port  
EXPOSE 8701 3000-3003  
ENTRYPOINT ["/usr/bin/slc"]  

