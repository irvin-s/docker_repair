FROM eeacms/zope:2.8.0  
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>  
  
# Path to zeostorage  
ENV STORAGE_PATH /var/local/zeostorage  
  
# Create zeo instance  
RUN python $ZOPE_PATH/bin/mkzeoinstance.py $STORAGE_PATH  
RUN chown -R 500:500 $STORAGE_PATH  
  
ENV ZOPE_USER zope  
  
# Create user=zope with uid=500 gid=500 groups=500  
RUN groupadd -g 500 zope && \  
useradd zope -g zope && \  
usermod -u 500 zope  
  
# Python 3.4 install  
RUN yum -y install epel-release && \  
yum install python34-devel -y && \  
curl -s "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \  
python3 get-pip.py && \  
  
# Chaperone install  
pip3 install chaperone && \  
yum clean all && rm -rf /tmp/*  
  
# Chaperone setup  
COPY chaperone.conf /etc/chaperone.d/chaperone.conf  
  
USER zope  
  
ENTRYPOINT ["/usr/bin/chaperone"]  
CMD ["--user", "zope"]  

