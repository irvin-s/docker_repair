FROM google/golang  
MAINTAINER codeskyblue@gmail.com  
  
RUN go get -v github.com/codeskyblue/unsafessh  
ADD entry.sh /  
RUN chmod +x entry.sh  
  
ENTRYPOINT ["/entry.sh"]  
CMD ["bash"]  

