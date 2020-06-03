FROM couchbase:community-5.1.1

COPY /configure.sh /

RUN ["chmod", "+x", "/configure.sh"]

ENTRYPOINT ["/configure.sh"]
