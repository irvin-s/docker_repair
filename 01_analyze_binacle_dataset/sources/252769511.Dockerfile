FROM kkarczmarczyk/node-yarn:6.9-slim  
  
RUN mkdir -p /opt/app/ \  
&& mkdir -p /opt/app/server \  
&& mkdir -p /opt/app/assets \  
&& mkdir -p /opt/app/build \  
&& mkdir -p /opt/app/files/scenarios/ \  
&& mkdir -p /opt/app/files/reports/  
  
VOLUME /opt/app/files  
  
WORKDIR /opt/app  
  
# Copy app code  
COPY package.json postcss.config.js yarn.lock ./  
COPY internals internals  
COPY assets assets  
COPY server server  
COPY app app  
  
# Install packages  
RUN cd /opt/app \  
&& yarn --ignore-scripts \  
&& npm run build \  
&& npm prune --productin \  
&& rm -rf /opt/app/internals \  
&& rm -rf /opt/app/app \  
  
EXPOSE 3000  
CMD cd /opt/app \  
&& npm run start:prod

