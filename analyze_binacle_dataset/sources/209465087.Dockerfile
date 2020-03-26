FROM scratch
ADD files/alpine-minirootfs-3.6.1-x86_64.tar /
COPY files/1.txt /1.txt
CMD ["/bin/sh"]
