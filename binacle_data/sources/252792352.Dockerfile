# This Dockerfile is a base image with duplicacy installed  
From golang:latest  
LABEL maintainer="Michael Hsu"  
  
# Vars  
ENV DUPLICACY_SOURCE="https://github.com/gilbertchen/duplicacy.git"  
ENV DUPLICACY_BASE_NAME="duplicacy"  
ENV DUPLICACY_SOURCE_HASH="c829b80"  
# Clone duplicacy source  
WORKDIR /go/src  
RUN git clone $DUPLICACY_SOURCE && \  
cd ${DUPLICACY_BASE_NAME} && \  
git reset --hard ${DUPLICACY_SOURCE_HASH}  
  
# Build duplicacy  
WORKDIR /go/src  
RUN go get ${DUPLICACY_BASE_NAME}/...  
RUN go build ${DUPLICACY_BASE_NAME}/...  
RUN cp /go/bin/${DUPLICACY_BASE_NAME} /${DUPLICACY_BASE_NAME}  
  
RUN mkdir /backup  
RUN mkdir /restore  
  
ENTRYPOINT ["/bin/sh"]  

