FROM registry.saintic.com/python

MAINTAINER Mr.tao <staugur@saintic.com>

ADD . /Interest.blog

RUN cp -f /Interest.blog/misc/supervisord.conf /etc/ &&\
    pip install --index https://pypi.douban.com/simple/ -r /Interest.blog/requirements.txt

WORKDIR /Interest.blog

ENTRYPOINT ["supervisord"]
