FROM scratch
ADD main /
ADD login.gtpl /
EXPOSE 8080
ENTRYPOINT ["/main"]
