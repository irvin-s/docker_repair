FROM danielguerra/alpine-sshdx  
RUN apk --update --no-cache add wireshark  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["/usr/sbin/sshd","-D"]  

