  
####################  
# Compilation image stage  
############################  
  
FROM alpine:latest  
  
# Install base packages  
RUN apk update && apk add git build-base linux-headers bind-tools  
  
# Download 3proxy 0.8.8  
RUN mkdir -p /usr/src  
WORKDIR /usr/src  
RUN git clone https://github.com/z3APA3A/3proxy.git  
WORKDIR /usr/src/3proxy  
RUN git checkout tags/0.8.11  
  
# Compile and install 3proxy  
RUN make -f Makefile.Linux && \  
make -f Makefile.Linux install  
  
#######################  
# Execution image stage  
#########################  
  
FROM alpine:latest  
  
# Define default ENV values  
ENV SERVER=127.0.0.1  
ENV USER=user  
ENV PASSWORD=password  
ENV PORT=3128  
ENV DNS1=1.1.1.1  
ENV DNS2=8.8.8.8  
  
# Install and setup 3proxy files  
  
COPY --from=0 /usr/local/bin/ /usr/local/bin/  
  
RUN mkdir -p /usr/local/etc/3proxy/logs && apk update && apk add bind-tools  
WORKDIR /usr/local/etc/3proxy/  
  
ADD 3proxy.cfg.dist /usr/local/etc/3proxy/  
ADD docker-entrypoint.sh /usr/local/etc/3proxy/  
  
EXPOSE $PORT  
ENTRYPOINT ["/usr/local/etc/3proxy/docker-entrypoint.sh"]  
  
CMD ["start_proxy"]  

