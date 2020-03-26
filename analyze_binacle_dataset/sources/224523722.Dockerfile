FROM besn0847/alpinevpn

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \ 
	apk update && \
        apk add openvpn socat supervisor consul@testing && \
	mkdir /data 

ADD ./bin/ /bin/
ADD ./etc/openvpn/ /etc/openvpn/
ADD ./etc/ssl/ /etc/ssl/
ADD ./etc/supervisor.d/ /etc/supervisor.d/
ADD ./static/ /static/

CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisord.conf

