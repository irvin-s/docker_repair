FROM danielguerra/alpine-sshdx  
RUN apk --update --no-cache add firefox-esr \  
&& rm -rf /tmp/* /var/cache/apk/*  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["/usr/sbin/sshd","-D"]  

