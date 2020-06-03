FROM alpine  
  
RUN apk update  
RUN apk add doxygen graphviz curl openssh font-adobe-100dpi  
RUN mkdir -p $HOME/.ssh  
  
COPY script.sh $HOME  
  
CMD ["/bin/sh", "script.sh"]  

