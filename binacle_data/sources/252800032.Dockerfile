FROM frekele/gradle  
MAINTAINER dimkk  
COPY . /usr/riftmanager/  
WORKDIR /usr/riftmanager  
  
ENTRYPOINT ["gradle", "run"]

