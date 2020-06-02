FROM bayesian-api
MAINTAINER Tomas Tomecek <ttomecek@redhat.com>

ENV PYTHONDONTWRITEBYTECODE 1

COPY . /bayesian
RUN cd /bayesian/tests && pip3 install -r ./requirements.txt

ENV POSTGRESQL_USER=coreapi
ENV POSTGRESQL_PASSWORD=coreapi
ENV POSTGRESQL_DATABASE=coreapi
ENV PGBOUNCER_SERVICE_HOST=coreapi-pgbouncer
ENV DISABLE_AUTHENTICATION 1

# This is needed for codecov so the CWD is writeable and codecov can write stats to a file.
WORKDIR /tmp

CMD ["py.test"]
# ENTRYPOINT ["/bayesian/hack/exec_tests.sh"]
