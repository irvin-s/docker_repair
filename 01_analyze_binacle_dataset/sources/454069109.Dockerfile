FROM alpine
ADD projection-srv /projection-srv
ENTRYPOINT [ "/projection-srv" ]
