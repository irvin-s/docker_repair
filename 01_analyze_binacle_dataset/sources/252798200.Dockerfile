FROM alpine:3.4  
MAINTAINER Mathieu Viossat <mathieu@viossat.fr>  
  
ENV REPO=/repo \  
GIT_DIR=/repo/.git \  
CRON="* * * * *"  
RUN apk add --no-cache \  
git \  
openssh-client \  
&& mkdir /root/.ssh \  
&& echo -e "Host *\n\tStrictHostKeyChecking no" > /root/.ssh/config  
  
COPY entrypoint.sh sync.sh /  
  
VOLUME /repo /root/.ssh  
WORKDIR /repo  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["crond", "-f"]  

