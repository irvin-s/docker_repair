FROM ruby:2-alpine  
  
RUN apk update  
RUN apk add --update gcc make g++ openssh \  
git \  
&& rm -rf /var/cache/apk/*  
  
ENV dir /root  
WORKDIR ${dir}  
  
RUN mkdir -p ${dir}/source  
ADD bin/cap ${dir}/cap  
  
CMD ["sh"]  

