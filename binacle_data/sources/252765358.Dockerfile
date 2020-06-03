FROM scratch  
ADD root.tar.gz /  
CMD ["/bin/asmttpd","/var/www"]  

