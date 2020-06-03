FROM quay.io/koli/base-os

RUN groupadd -r git --gid=2000 && useradd --home /home/git -r -g git --uid=2000 git

WORKDIR /home/git
COPY . /
RUN chown -R git: /home/git

USER git

EXPOSE 8000
EXPOSE 8001

ENTRYPOINT ["/usr/bin/gitserver"]

