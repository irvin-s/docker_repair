FROM gliderlabs/alpine:3.1

ADD dnscock /dnscock
RUN chmod +x /dnscock

EXPOSE 53/udp

ENTRYPOINT ["/dnscock"] 
