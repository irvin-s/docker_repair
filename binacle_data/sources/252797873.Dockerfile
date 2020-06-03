# This is a two-stage Docker build:  
# https://docs.docker.com/develop/develop-images/multistage-build  
#  
# Build container  
FROM golang:1.10.1 AS BUILDER  
  
WORKDIR /go/src/bitbucket.org/bgv/adserve  
COPY . .  
RUN make all  
  
# Runtime container  
FROM alpine:latest  
COPY \--from=BUILDER /go/src/bitbucket.org/bgv/adserve/adserve /bin/adserve  
  
EXPOSE 9090  
VOLUME [ "/adserve" ]  
WORKDIR /adserve  
ENTRYPOINT [ "/bin/adserve" ]  
CMD [ "--web.images-path=/adserve", \  
"--db.path=/adserve/adserve.db" ]  

