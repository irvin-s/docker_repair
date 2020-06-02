FROM alpine:3.4
ADD app /bin/app
CMD ["app"]
EXPOSE 8080
