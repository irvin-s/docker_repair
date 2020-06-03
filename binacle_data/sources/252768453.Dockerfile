##################################################  
##  
## Golang  
##  
##################################################  
FROM golang:1.10  
MAINTAINER Jason Kulatunga <jason@thesparktree.com>  
  
WORKDIR /srv/capsulecd  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
apt-transport-https \  
ca-certificates \  
git \  
curl \  
locales \  
&& rm -rf /var/lib/apt/lists/* \  
&& locale-gen en_US.UTF-8 \  
&& go get -u gopkg.in/alecthomas/gometalinter.v1 \  
&& gometalinter.v1 --install \  
&& go get github.com/Masterminds/glide  
  
  
ENV PATH="/srv/capsulecd:${PATH}" \  
SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt \  
LANG=en_US.UTF-8 \  
LANGUAGE=en_US.UTF-8 \  
LC_ALL=en_US.UTF-8  
  
COPY ./capsulecd.sh .  
  
RUN ./capsulecd.sh  
  
CMD "capsulecd"  

