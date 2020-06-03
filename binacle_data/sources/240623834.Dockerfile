FROM google/golang

ADD ./membrane .

COPY public /public

EXPOSE 8080

CMD ["./membrane"]
