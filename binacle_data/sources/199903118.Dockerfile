FROM phusion/baseimage

RUN apt-get update

RUN apt-get install -y build-essential

RUN curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
apt-get install -y nodejs python

RUN npm install -g pnpm

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man/?? /usr/share/man/??_* /usr/share/man/??.*

EXPOSE 4000

ENTRYPOINT ["/sbin/my_init", "--", "/app/run.sh"]

WORKDIR /app

COPY . ./

# You can test container
# docker build -t ice/test0 .
# docker run --name "tmp" -it --rm -p 3000:4000 -e LALA=LALA ice/test0
