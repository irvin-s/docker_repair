FROM alpine 

COPY ./dist/mesh /root

ENTRYPOINT   [ "/root/mesh" ]
