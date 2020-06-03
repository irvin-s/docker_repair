FROM scratch

EXPOSE 8080

COPY hello /
COPY templates templates

CMD ["/hello"]