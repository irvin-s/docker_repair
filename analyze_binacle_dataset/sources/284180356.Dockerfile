FROM centos:7.3.1611

RUN mkdir -m 777 /poc
WORKDIR /poc/

COPY CVE-2017-1000253 .
COPY CVE-2017-1000253.c .
COPY rootshell .
COPY rootshell.c .
COPY rootshell.h .
COPY ping .

RUN chown root:root ping && chmod 4755 ping

ENTRYPOINT ["./CVE-2017-1000253"]
CMD ["ping"]
