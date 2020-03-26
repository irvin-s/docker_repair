FROM centos  
COPY centos_copy_file /tmp  
CMD cd tmp && ls  

