FROM ubuntu:xenial  
MAINTAINER Boro <docker@bo.ro>  
  
RUN apt-get update  
RUN apt-get install -y software-properties-common locales  
  
# Set locale  
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \  
locale-gen  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
RUN locale-gen en_US.UTF-8  
RUN export LANG=en_US.UTF-8  
  
RUN add-apt-repository -y ppa:cz.nic-labs/bird  
RUN apt-get update  
RUN apt-get install -y bird  
  
RUN mkdir /run/bird && chmod 777 /run/bird  
RUN touch /run/bird/bird.ctl  
RUN touch /run/bird/bird6.ctl  
  
# Make a backup of the default config files  
RUN cp /etc/bird/bird.conf /etc/bird/bird.default.conf  
RUN cp /etc/bird/bird6.conf /etc/bird/bird6.default.conf  
  
ADD bird.template.conf /etc/bird/bird.template.conf  
ADD bird6.template.conf /etc/bird/bird6.template.conf  
  
ADD start.sh /start.sh  
RUN chmod 755 /start.sh  
  
CMD /start.sh

