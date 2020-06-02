FROM golang
COPY simpleExec /
CMD ["/simpleExec"]
EXPOSE 8080
