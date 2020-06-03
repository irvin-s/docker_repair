FROM node:6  
ARG PARSOID_VERSION=v0.8.0  
ENV WORKDIR /usr/src/parsoid  
WORKDIR $WORKDIR  
EXPOSE 8000  
RUN set -x; \  
git clone \  
\--depth 1 \  
-b ${PARSOID_VERSION} \  
https://github.com/wikimedia/parsoid \  
$WORKDIR \  
&& rm -rf $WORKDIR/.git/  
  
RUN npm install && npm cache clean --force  
  
RUN mkdir -p /data  
VOLUME /data  
  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["npm", "start"]  

