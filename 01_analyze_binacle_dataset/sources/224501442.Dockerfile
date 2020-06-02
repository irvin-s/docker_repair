FROM scratch
ADD main /
ADD config.json /
EXPOSE  8080
CMD ["/main"]

