FROM golang
ENV IMAGR_PASSWORD="password"
RUN go get -u github.com/groob/imagr-server
ENTRYPOINT ["imagr-server", "-repo", "/imagr_repo", "-serve"]

VOLUME ["/imagr_repo"]
EXPOSE 3000

