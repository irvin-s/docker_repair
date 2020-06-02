FROM busybox
LABEL "maintainer"="tangfeixiong <tangfx128@gmail.com>" \
    "project"="https://github.com/tangfeixiong/go-to-kubernetes" \
    "name"="rap" \
    "version"="0.1" \
    "created-by"='{"name":"go-to-kubernetesr","namespace":"default","version":"0.1"}'

COPY bin/rap /

EXPOSE 10071 10072

ENTRYPOINT ["/rap", "serve"]
CMD ["-v", "2", "--logtostderr=true"]
