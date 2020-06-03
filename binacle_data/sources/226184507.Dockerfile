FROM node:6

ADD bin/kubectl-1.4.5 /usr/bin/kubectl
RUN chmod a+x /usr/bin/kubectl

ADD bin/helm-2.0.0-rc.1 /usr/bin/helm
RUN chmod a+x /usr/bin/helm

RUN npm install -g phantomjs

RUN apt-get update && \
    apt-get install -y uuid-runtime postgresql-client && \
    rm -rf /var/lib/apt/lists/*
