
FROM dystroy/gomysql:latest as builder

COPY ./go/src/chrall/ /go/src/chrall/
COPY ./go/src/chrallserver/ /go/src/chrallserver/

RUN go install chrall
RUN go install chrallserver

FROM alpine:3.7
COPY --from=builder /go/bin/chrallserver /chrallserver

ENV	GOGO_PORT="9090"
ENV	GOGO_DB_CONNECTION="temp_user:temp_password@tcp(mysql:3306)/chrall?collation=utf8mb4_unicode_ci&charset=utf8mb4,utf8"

EXPOSE 9090

ENTRYPOINT ["./chrallserver", "-dir", "/"]
