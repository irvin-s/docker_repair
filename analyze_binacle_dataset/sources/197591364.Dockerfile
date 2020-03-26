FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
ADD forwardhook /
CMD ["/forwardhook"]
