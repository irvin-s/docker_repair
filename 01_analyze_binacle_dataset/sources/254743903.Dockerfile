FROM registry.cn-beijing.aliyuncs.com/staugur/python
MAINTAINER staugur <staugur@saintic.com>
ADD src /passport
ADD requirements.txt /tmp
RUN yum install -y gcc gcc-c++ python-devel libffi-devel openssl-devel mysql-devel &&\
    pip install --timeout 30 --index https://pypi.douban.com/simple/ -r /tmp/requirements.txt
WORKDIR /passport
ENTRYPOINT ["sh", "online_gunicorn.sh", "run"]