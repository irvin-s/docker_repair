FROM dsop/alpine-base:3.5  
ENV AWSCLI 1.11.112  
RUN apk --update add git openssh-client python py-pip && \  
rm -rf /var/cache/apk/*  
  
RUN pip install --upgrade pip  
  
RUN pip install awscli==${AWSCLI}  
  
WORKDIR /work  
  
ENTRYPOINT ["aws"]  
  

