FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
ruby  
  
RUN gem install scout_realtime  
  
EXPOSE 5555  
ENTRYPOINT ["scout_realtime"]  
CMD ["-f", "start"]  

