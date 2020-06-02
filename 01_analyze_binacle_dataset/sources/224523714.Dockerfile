FROM alpine

RUN apk update && \
	apk add openvpn socat supervisor

ADD ./bin/ /bin/
ADD ./etc/supervisord.conf /etc/
ADD ./etc/openvpn/docker.ovpn /etc/openvpn/
ADD ./etc/ssl/ /etc/ssl/
ADD ./etc/supervisor.d/agent.ini /etc/supervisor.d/

CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisord.conf  
