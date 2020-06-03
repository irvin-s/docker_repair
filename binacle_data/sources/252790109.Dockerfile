FROM scratch  
COPY docker_volume_info /  
ENTRYPOINT ["/docker_volume_info"]  

