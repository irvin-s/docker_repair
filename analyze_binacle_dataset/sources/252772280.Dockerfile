FROM avastsoftware/cpanm  
  
MAINTAINER Avast Viruslab Systems  
  
COPY cpanfile cpanfile  
RUN cpanm --installdeps .  
COPY critic_html /var/lib/critic_html  
RUN ln -s /var/lib/critic_html/critichtml /usr/bin/critichtml  
  
WORKDIR /tmp/workspace  
  
ENTRYPOINT ["critichtml"]  

