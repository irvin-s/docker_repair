FROM colstrom/ruby  
  
RUN apk-install ruby-json  
RUN gem-install concourse-fuselage  
  
WORKDIR /opt/resource  

