FROM mongo:3.6.4  
ENV TZ=Australia/Melbourne  
  
COPY ./ /  
  
RUN apt-get update -y && apt-get upgrade -y && \  
apt-get install -y tzdata && \  
chmod +x /*.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["mongod", "--auth"]  

