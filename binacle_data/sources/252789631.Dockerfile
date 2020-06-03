FROM dustywilson/golang-devenv:rc  
MAINTAINER Dusty Wilson <dusty@linux.com>  
  
# switch back to root user  
USER root  
  
# install atom  
RUN curl -L https://atom.io/download/deb > /tmp/atom.deb && \  
dpkg -i /tmp/atom.deb && \  
rm -f /tmp/atom.deb  
  
# switch back to user  
USER user  
# prep expected dirs  
RUN mkdir -p /user/.atom  
  
# setup volumes  
VOLUME ["/user/.atom"]  
  
# setup exec  
COPY exec.sh /user/exec.sh  
ENTRYPOINT ["/user/exec.sh"]  

