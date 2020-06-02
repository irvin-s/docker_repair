FROM ubuntu:latest

ARG "version=0.1.0-dev"
ARG "build_date=unknown"
ARG "commit_hash=unknown"
ARG "vcs_url=unknown"
ARG "vcs_branch=unknown"

LABEL org.label-schema.vendor="Softonic" \
    org.label-schema.name="swarm-backup-restore" \
    org.label-schema.description="Allow operators to backup automatically the cluster and restore it on bootstrap using S3." \
    org.label-schema.usage="README.md" \
    org.label-schema.url="https://github.com/softonic/swarm-backup-restore/blob/master/README.md" \
    org.label-schema.vcs-url=$vcs_url \
    org.label-schema.vcs-branch=$vcs_branch \
    org.label-schema.vcs-ref=$commit_hash \
    org.label-schema.version=$version \
    org.label-schema.schema-version="0.1" \
    org.label-schema.docker.cmd.devel="" \
    org.label-schema.docker.params="BUCKET=Bucket where the backups will be stored,\
REGION=Bucket region,\
AWS_KEY_ID_SECRET=Secret name where the AWS_KEY_ID is stored,\
AWS_ACCESS_KEY_SECRET=Secret name where the AWS_ACCESS_KEY is stored,\
NAMESPACE=Namespace tu be used in S3 to store the objects, \
IGNORE_STACKS=Stacks to not be backup separated by commas" \
    org.label-schema.build-date=$build_date

ADD /app /app

RUN apt-get update \
	&& apt-get -y install curl openssl

WORKDIR /app

CMD /app/backup.sh