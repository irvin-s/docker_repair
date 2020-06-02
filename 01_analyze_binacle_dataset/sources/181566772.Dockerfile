FROM python

MAINTAINER Giorgos Papaefthymiou <george.yord@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update --quiet > /dev/null && \
  apt-get install --assume-yes --force-yes -qq \
  git  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN mkdir -p /code

WORKDIR /code

RUN git clone --depth 1 --single-branch https://github.com/reactjs/react-tutorial.git /code && \
    pip install -r requirements.txt

RUN sed -i "s/app.run(port=int(os.environ.get(\"PORT\",3000)))/app.run(debug=True, host='0.0.0.0', port=int(os.environ.get(\"PORT\",3000)))/g" server.py

ADD bin/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 3000

CMD ["/init.sh"]
