FROM golang:1.3.1-onbuild

EXPOSE 5000

ENTRYPOINT ["/go/bin/git-archive-daemon"]
