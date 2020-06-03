FROM alpine/git
ADD create-commit-file /usr/local/bin/create-commit-file
ENTRYPOINT ["/usr/local/bin/create-commit-file"]
