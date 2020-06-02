FROM mhart/alpine-node:6.10.3  
RUN apk add --no-cache make gcc g++ python  
  
COPY formio /srv/formio  
  
RUN cd /srv/formio && npm rebuild  
  
RUN chmod +x /srv/formio/docker/*.sh  
  
EXPOSE 80  
ENTRYPOINT /srv/formio/docker/run.sh  
  
CMD ['']  

