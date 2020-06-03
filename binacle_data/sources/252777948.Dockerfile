FROM ruby:2.1  
MAINTAINER Angel Pino <angelmpino87@yahoo.com>  
  
RUN echo "Installing eventmachine" \  
&& gem install eventmachine  
  
RUN echo "Installing daemons" \  
&& gem install daemons  
  
RUN echo "Installing zip" && apt-get update \  
&& apt-get install -y zip  
  
RUN echo "Downloading and unziping liverpie" && cd /home \  
&& wget http://www.liverpie.com/liverpie-0.5.zip \  
&& unzip liverpie-0.5.zip \  
&& chmod -R 777 liverpie  
  
WORKDIR /home/liverpie  
  
COPY launch.rb .  
  
#COPY config.yml config/liverpie.yml  
VOLUME ["/home/liverpie/config"]  
  
#CMD ["./bin/liverpie", "-h"]  
CMD ["ruby", "-I", ".", "launch.rb"]  
  
EXPOSE 8084  

