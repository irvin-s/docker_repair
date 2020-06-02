FROM alpine
ADD fillme.sh /
ENTRYPOINT ["/fillme.sh"]

