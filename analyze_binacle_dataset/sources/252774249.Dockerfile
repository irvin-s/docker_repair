FROM ambidexterich/node-yarn  
LABEL maintainer="github@rhamburg.com"  
  
RUN yarn global add create-react-app \  
&& cd / && create-react-app app \  
&& mkdir -p /root/src \  
&& mv /app/src/* /root/src/  
  
COPY entrypoint.sh /entrypoint.sh  
  
EXPOSE 3000  
VOLUME /app/src  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD cd /app && yarn start  

