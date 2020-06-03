# Testing with python 3

FROM python:3

RUN pip3 install pytest six pyyaml jinja2 colorlog watchdog pytest-mock

RUN adduser --uid 1009 --system testuser
RUN addgroup --gid 1010 testgroup

ENV PYTHONPATH /opt/

ADD tests/test_template.yml.tpl /tmp/test_template.yml
ADD tests/test_template.yml.tpl /tmp/test_template2.yml.tpl

WORKDIR /opt/tests

CMD ["py.test", "--verbose", "-rw", "."]
