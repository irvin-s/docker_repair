FROM concourse/git-resource  
  
ADD scripts/ /opt/resource/  
RUN chmod +x /opt/resource/*  
ENV PATH /bin:/usr/bin:/usr/local/bin:$PATH  

