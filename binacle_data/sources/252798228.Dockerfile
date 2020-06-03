FROM golang:1.3.3  
MAINTAINER docker@deliverous.com  
  
RUN \  
apt-get update \  
&& apt-get install -y --no-install-recommends \  
openssh-client  
  
# Perpare run command  
ADD run /usr/local/bin/run  
RUN chmod 755 /usr/local/bin/run  
  
# Prepare ssh share space  
RUN mkdir /ssh  
  
RUN mkdir -p /root/.ssh \  
&& touch /root/.ssh/known_hosts \  
&& ssh-keyscan git.azae.net >> /root/.ssh/known_hosts \  
&& ssh-keyscan github.com >> /root/.ssh/known_hosts \  
&& ssh-keyscan git.deliverous.com >> /root/.ssh/known_hosts  
  
VOLUME ["/go", "/ssh"]  
ENTRYPOINT ["/usr/local/bin/run"]  

