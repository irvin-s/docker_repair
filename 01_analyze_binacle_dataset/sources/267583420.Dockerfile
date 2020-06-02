FROM nginx:alpine

# The DATA_SOURCE is where we get the resolver information from.
ARG DATA_SOURCE=global

# Set up a working directory.
ENV WDIR /eidolon

RUN mkdir $WDIR

COPY python $WDIR/python
COPY requirements.txt $WDIR/

# This long command installs python3 and requests, then runs
# two scripts to generate the nginx.conf file, before cleaning
# up all dependencies.
RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    python3 -m venv $WDIR/env && \
    . $WDIR/env/bin/activate && \
    pip3 install --no-cache-dir -r $WDIR/requirements.txt && \
    python3 $WDIR/python/resolver_publicdns.py --database $WDIR/resolvers.db --publicdns $DATA_SOURCE && \
    python3 $WDIR/python/generate_nginx_conf.py --database $WDIR/resolvers.db --outputfile /etc/nginx/nginx.conf && \
    apk del --purge python3 && \
    rm -rf $WDIR/env && \
    rm -v $WDIR/resolvers.db

EXPOSE 5353
