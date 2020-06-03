FROM python:3

RUN pip install rethinkdb

CMD [ "/bin/bash" ]