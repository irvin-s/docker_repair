
FROM scratch
EXPOSE 8000

ADD basic-app /

CMD ["/basic-app"]