# docker build --build-arg="SSH_PRIVATE_KEY=`cat ~/.ssh/id_rsa`" .  
# STAGE0  
FROM golang:latest as builder  
  
LABEL Christian Sakshaug <christian@dx.no>  
  
COPY . /ci/  
  
WORKDIR /ci  
  
RUN mkdir -p /go/src/github.com/dialogexe  
RUN make  
RUN mv bin outputs  
RUN mkdir bin  
RUN mv outputs/ciset-linux-amd64 /ci/bin/ciset  
RUN mv .docker-cmd.sh /ci/bin/execute.sh  
  
# STAGE1  
FROM ubuntu:latest  
  
RUN apt-get update && apt-get install -y openssh-client bash git curl  
  
# COPY FROM STAGE0 SO WE DONT TAKE WITH SECRETS  
COPY \--from=builder /ci/bin /ci/bin  
  
RUN chmod +x /ci/bin/ciset /ci/bin/execute.sh  
  
WORKDIR /ci/bin  
  
CMD ["/ci/bin/execute.sh"]  

