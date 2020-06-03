FROM hakobera/locust

ADD ./test /test
ENV SCENARIO_FILE /test/locustfile.py
