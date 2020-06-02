FROM chemowakate/tutorial-6th  
  
USER root  
RUN apt-get update \  
&& apt-get install -y graphviz \  
&& apt-get clean \  
&& pip install graphviz  

