FROM alpine:3.4

MAINTAINER Jose Armesto <jose@armesto.net>

ARG vcs_type="Git"
ARG vcs_url="Unknown"
ARG vcs_ref="Unknown"
ARG vcs_branch="Unknown"
ARG build_date="Unknown"

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["python", "-m", "dredd"]

COPY ./Dockerfile /Dockerfile

RUN apk add --update --repository https://dl-cdn.alpinelinux.org/alpine/edge/community/ tini=0.9.0-r1 py-pip=8.1.2-r0

LABEL org.label-schema.vcs-type=$vcs_type \
      org.label-schema.vcs-url=$vcs_url \
      org.label-schema.vcs-ref=$vcs_ref \
      org.label-schema.vcs-branch=$vcs_branch \
      org.label-schema.docker.dockerfile=/Dockerfile \
      org.label-schema.build-date=$build_date

WORKDIR /code

COPY . /code/

RUN pip install -r requirements.txt
