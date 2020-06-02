FROM ruby:2.1  
RUN apt-get update && apt-get install -y vim && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN gem install vimgolf-finder vimgolf  
  
ADD entrypoint.sh /bin/find-vimgolf  
ADD entrypoint-play.sh /bin/play-vimgolf  
  
CMD ["/bin/find-vimgolf"]  

