FROM ruby  
MAINTAINER Jan Mosat <mosat@weps.cz>  
  
RUN gem install typhoeus  
  
WORKDIR . /home/  
  
COPY . /home/  
  
ENTRYPOINT ruby /home/download_csv.rb

