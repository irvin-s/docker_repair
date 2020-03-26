FROM scratch

COPY content/ /

EXPOSE 9000
ENTRYPOINT ["/dockerui"]
