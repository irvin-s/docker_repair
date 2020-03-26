FROM ctarwater/docker-open-publisher-base  
MAINTAINER chrisanthropic <ctarwater@gmail.com>  
  
# Build command: docker build -t open-publisher .  
ADD . Open-Publisher/  
  
WORKDIR /Open-Publisher  
  
#ENTRYPOINT ["bundle exec rake"]  
CMD [""]  

