FROM gliderlabs/alpine:3.3
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="mysql_sql_executor" Vendor="sortuniq" Version="0.0.1" \
      Description="Fetches an sql file from S3 and runs it against a remote host."
#
# instructions and example usage at bottom of Dockerfile
#
ENV ASSETS_DIR="assets"                \
    ASSETS_DOCKER="/var/tmp/assets"    \
    AWS_REGION="eu-west-1"             \
    DBHOST=""                          \
    DBNAME=""                          \
    DBPASS=""                          \
    DBPORT="3306"                      \
    DBUSER="root"                      \
    SQL_S3_PATH=""                     \
    CMD_SCRIPT="mysql_sql_executor.sh" \
    SCRIPTS_DOCKER="/var/tmp/assets/build-scripts-alpine"

COPY $ASSETS_DIR $ASSETS_DOCKER

RUN chmod a+x $SCRIPTS_DOCKER/*             \
    && cp $ASSETS_DOCKER/$CMD_SCRIPT /      \
    && chmod a+x /$CMD_SCRIPT               \ 
    && apk --no-cache add mysql-client      \
    && $SCRIPTS_DOCKER/install_awscli.sh    \
    && $SCRIPTS_DOCKER/create_user_core.sh  \
    && rm -rf /var/cache/apk/* $ASSETS_DOCKER 2>/dev/null

USER core

CMD ["bash", "-C", "/mysql_sql_executor.sh"]

# __END__
# build instructions:
# cd assets && git clone git@github.com:jinal--shah/build-scripts-alpine && cd ..
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable

# run instructions:
# You must pass some env vars to docker run (using --env)
# See $CMD_SCRIPT for details.
#
# PRO-TIP:
# Any sensitive value should not be passed using --env long form e.g.
# Don't use --env PASSWORD=<sensitive values>.
# Instead, set the value in your env before running, and just use
#     --env PASSWORD
#
# e.g.
# export DBPASS=my-secret-val
# docker run --name boo           \
#    --env AWS_REGION=eu-west-1   \
#    --env DBHOST=boo.example.com \
#    --env DBPASS                 \
#    --env DBPORT=3306            \
#    --env DBUSER=boo             \
#    --env DBNAME=boo             \
#    --env SQL_S3_PATH=s3://eurostar.builds/evo/build-eurostar-site/dev/D8-responsive-20151026.sql.gz \
#        mysql_sql_executor:0.0.1
#
