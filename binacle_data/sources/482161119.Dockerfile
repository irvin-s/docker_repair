FROM scratch

ADD ./dist/siapool /siapool

EXPOSE 9985

ENTRYPOINT ["/siapool"]
