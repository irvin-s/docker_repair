FROM gerritforge/gerrit-ubuntu15.04:2.11.3
MAINTAINER svanoort

USER root
RUN apt-get update && apt-get install -y curl python net-tools && \
    rm -rf /var/lib/apt/lists/*
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /bin/repo \
    && chmod a+x /bin/repo

COPY ReviewDB.h2.db /var/gerrit/db/ReviewDB.h2.db
COPY repos /tmp/repos-wc
RUN chown -R gerrit:gerrit /tmp/repos-wc var/gerrit/db/ReviewDB.h2.db

# Git access to repo
EXPOSE 9418

USER gerrit
RUN git config --global user.email "demouser@example.com" && \
    git config --global user.name "Demo User"

# This is how we save gerrit user/project configuration

# Create repo working copies & then do bare clones to expose for work
RUN cd /tmp/repos-wc && mkdir /tmp/repos && \
    for r in primary secondary umbrella workflow; do ( \
        cd $r; git init && git add . && git commit -am "Initial commit"; \
        git clone --bare /tmp/repos-wc/$r /var/gerrit/git/$r.git; \
    ); done;

CMD /var/gerrit/bin/gerrit.sh start && tail -f /var/gerrit/logs/error_log

# Docker doesn't set this to user home by default
ENV HOME /var/gerrit