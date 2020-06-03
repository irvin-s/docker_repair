FROM contentwisetv/node-waitforit-goreplay:9  
  
ARG KONGFIG_VERSION=1.3.0  
  
USER root  
RUN npm install -g kongfig@${KONGFIG_VERSION}  
COPY run.sh /opt/  
  
USER node  
ENTRYPOINT [ "/opt/run.sh" ]  
CMD ["--help"]

