FROM aksaramaya/base

# set environment
ENV APP=/opt/od

RUN apk add --update git python make gcc libc-dev g++ mariadb-dev py-pip python-dev
# Create app directory
RUN mkdir -p $APP

# Install app dependencies
COPY requirements.txt $APP
RUN pip install -r $APP/requirements.txt

RUN apk del make gcc libc-dev g++
COPY init.sh /
RUN apk add --update mariadb-client
WORKDIR $APP
ENTRYPOINT ["/init.sh"]
