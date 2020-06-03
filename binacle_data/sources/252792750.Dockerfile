FROM busybox:latest  
ARG test="abc"  
ARG hello  
RUN pwd  
RUN echo $test  
RUN echo $hello  
RUN echo "Hi bye"  

