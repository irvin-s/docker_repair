FROM frolvlad/alpine-bash  
  
COPY ./ /tmp/src  
RUN cd /tmp/src && chmod +x build.sh && ./build.sh  
  
ENV PATH="/go/bin:$PATH"  
WORKDIR /go  
  
ENTRYPOINT ["amdatu-kubernetes-deployer"]

