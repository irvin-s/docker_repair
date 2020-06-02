FROM vividcloud/meteor
MAINTAINER VividCloud

WORKDIR /app
ADD package.json /app/
RUN meteor npm install

COPY . /app/
RUN meteor build --allow-superuser --server-only --directory /
