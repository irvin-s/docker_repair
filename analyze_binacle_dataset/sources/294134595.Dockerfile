FROM scratch

COPY hello /
COPY templates templates

CMD ["/hello"]