FROM alpine:latest
RUN apk --no-cache add openvpn

RUN mkdir /usr/share/openvpn
RUN cp /etc/openvpn/* /usr/share/openvpn/

COPY wrapper.sh /wrapper.sh

WORKDIR /etc/openvpn

CMD /wrapper.sh
