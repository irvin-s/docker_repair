FROM cantara/configservice  
MAINTAINER Krzysztof Grodzicki <krzysztof@flowlab.no>  
  
ENV USER=configservice  
  
RUN apt-get update \  
&& apt-get install -y python-pip python-setuptools \  
&& pip install awscli-cwlogs \  
&& rm -rf /var/lib/apt/lists/*  
  
## Overwrite supervisord configuration  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
COPY config_override_templates/* $HOME/config_override/  
COPY toRoot/* $HOME/  
RUN chmod 755 $HOME/*.sh  
  
# Update permissions  
RUN chown -R $USER:$USER $HOME  
  
CMD /usr/bin/supervisord -c /etc/supervisor/supervisord.conf  

