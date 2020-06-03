FROM bitnami/minideb  
  
RUN apt-get update \  
&& apt-get install -y git-core build-essential  
  
RUN git clone https://git.linaro.org/people/david.rusling/Connect.git/  
RUN cd Connect \  
&& make  
  

