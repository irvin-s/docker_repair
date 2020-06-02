FROM couchbase/server:community
LABEL com.talend.name="Couchbase image for integration tests" \
      com.talend.application="components" \
      com.talend.service="couchbase" \
      com.talend.version="7.1.1" \
      com.talend.git.repositories="https://github.com/Talend/components" \
      com.talend.git.branches="master" \
      com.talend.description="Couchbase image for integration tests of Couchbase components" \
      com.talend.maintainer="Maksym Basiuk <mbasiuk@talend.com>" \
      com.talend.url="https://www.talend.com/" \
      com.talend.vendor="Talend" \
      com.talend.docker.cmd="docker run -d --name any-name -p 8091-8096:8091-8096 -p 11210-11211:11210-11211 repository:tag" \
      com.talend.docker.params="COUCHBASE_BASE_HOST=environment variable that sets Couchbase URL, \
        COUCHBASE_CLUSTER=environment variable that sets cluster name, \
        COUCHBASE_CLUSTER_PASSWORD=environment variable that sets cluster password, \
        COUCHBASE_BUCKET=environment variable that sets bucket name, \
        COUCHBASE_USER=environment variable that sets user with admin role, \
        COUCHBASE_USER_PASSWORD=environment variable that sets user password, \
        COUCHBASE_CLUSTER_RAM_SIZE=size of default cluster, \
        COUCHBASE_BUCKET_RAM_SIZE=size of created bucket(less than cluster size)"

COPY configure.sh /configure.sh
RUN chmod +x /configure.sh

ENTRYPOINT ["/configure.sh"]
