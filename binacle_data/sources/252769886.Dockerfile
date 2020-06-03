FROM alpine  
  
ARG TZ  
ENV TZ ${TZ:-America/Sao_Paulo}  
RUN mkdir /fakesqsdata  
  
RUN apk update && \  
apk upgrade && \  
apk add ruby ruby-rdoc tzdata  
  
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone  
  
RUN gem install fake_sqs --no-document  
  
EXPOSE 80  
VOLUME /fakesqsdata  
  
ENTRYPOINT fake_sqs --database /fakesqsdata/database.yml --port 80  

