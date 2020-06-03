FROM tianon/true
EXPOSE 1337

COPY certs/certs /etc/ssl/certs/
ADD main /

CMD ["/main"]
