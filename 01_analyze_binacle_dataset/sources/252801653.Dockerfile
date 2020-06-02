FROM ubuntu:14.04  
MAINTAINER Sebastian Tramp <sebastian.tramp@eccenca.com>  
  
ENV ECC_IMAGE_PREFIX nareike  
ENV ECC_IMAGE_NAME adhs  
  
# Let the conatiner know that there is no tty  
ENV DEBIAN_FRONTEND noninteractive  
  
# http://jaredmarkell.com/docker-and-locales/  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
# update ubuntu as well as install python3  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get install -qy python3 python3-pip && \  
apt-get clean  
RUN ln -s /usr/bin/python3 /usr/bin/python  
RUN ln -s /usr/bin/pip3 /usr/bin/pip  
  
ENV ADHS_HOME /opt/adhs  
RUN mkdir $ADHS_HOME  
WORKDIR $ADHS_HOME  
COPY adhs.py $ADHS_HOME/adhs.py  
COPY adhs_response.py $ADHS_HOME/adhs_response.py  
COPY requirements.txt $ADHS_HOME/requirements.txt  
COPY templates $ADHS_HOME/templates  
RUN pip install -r requirements.txt  
RUN ln -s $ADHS_HOME/adhs.py /usr/local/bin/adhs  
  
RUN mkdir /data  
COPY adhs.ttl /data/adhs.ttl  
  
VOLUME /data  
VOLUME /opt/adhs/templates  
EXPOSE 80  
ENV ADHS_INPUT turtle  
ENV ADHS_FILE /data/adhs.ttl  
  
CMD /opt/adhs/adhs.py -p 80 --host 0.0.0.0 -i $ADHS_INPUT $ADHS_FILE  
  

