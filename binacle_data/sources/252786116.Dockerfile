FROM busybox  
RUN dd of=./sprase-file bs=1 seek=10737418240 count=0  

