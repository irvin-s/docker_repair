FROM concourse/buildroot:ruby  
  
ADD bin/ /opt/resource  
RUN chmod +x /opt/resource/*  

