FROM gcc  
  
ENV PATH $PATH:/  
  
ADD do-oom.c /  
RUN gcc do-oom.c -o /do-oom  
  
CMD /do-oom  

