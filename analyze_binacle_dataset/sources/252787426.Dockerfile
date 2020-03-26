FROM brimstone/golang-musl AS builder  
  
COPY . /go/src/github.com/brimstone/dstm/  
  
WORKDIR /go/src/github.com/brimstone/dstm  
  
ENV VERBOSE=1  
RUN go get -v -d . \  
&& /loader -o /dstm  
  
FROM scratch  
  
ARG BUILD_DATE  
ARG VCS_REF  
  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.vcs-url="https://github.com/brimstone/dstm" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.schema-version="1.0.0-rc1"  
  
COPY \--from=builder dstm /  
  
ENV AUTH_WORKER= \  
AUTH_MANAGER=  
  
EXPOSE 8080  
ENTRYPOINT ["/dstm"]  
  
CMD ["serve"]  

