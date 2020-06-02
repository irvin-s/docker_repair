FROM busybox:1.27.2-glibc  
LABEL maintainer='Peter Wu <piterwu@outlook.com>'  
  
COPY lantern_linux_amd64 /lantern_linux_amd64  
RUN chmod +x /lantern_linux_amd64  
EXPOSE 8787  
CMD /lantern_linux_amd64 -addr 0.0.0.0:8787 -uiaddr 0.0.0.0:16823

