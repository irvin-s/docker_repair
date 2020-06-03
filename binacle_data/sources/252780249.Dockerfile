FROM alpine:3.2  
MAINTAINER Azuki <support@azukiapp.com>  
  
# Additional repositories  
RUN repositories="\  
http://dl-4.alpinelinux.org/alpine/v3.2/main/\  
@edge http://nl.alpinelinux.org/alpine/edge/main/\  
@community http://nl.alpinelinux.org/alpine/edge/community/" \  
&& echo -e $repositories | sed -e 's/\/\s/\/\n/g' > /etc/apk/repositories  
  
# install default packages  
RUN packages=' \  
bash \  
vim \  
git \  
tar \  
curl \  
wget \  
' \  
set -x \  
&& apk --update add $packages \  
&& rm -rf /var/cache/apk/*  
  
CMD ["sh"]  

