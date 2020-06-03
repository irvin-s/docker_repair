FROM clashclanvn/app_build:0.2  
RUN rm -rf /root/pyconjp-android /root/app-build.sh  
COPY app-build.sh /root/  
RUN chmod +x /root/app-build.sh  
RUN /root/app-build.sh  

