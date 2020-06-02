FROM bartoszj/swift:3.0-preview-2  
MAINTAINER Bartosz Janda  
  
EXPOSE 8080  
RUN git clone https://github.com/qutheory/vapor-example.git \  
&& cd vapor-example \  
&& swift build  
  
WORKDIR /vapor-example  
CMD [".build/debug/App"]  

