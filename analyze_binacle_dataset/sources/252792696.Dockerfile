FROM danielguerra/alpine-sshdx  
RUN apk --update --no-cache add chromium udev mesa-gl mesa-dri-swrast  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["/usr/sbin/sshd","-D"]  

