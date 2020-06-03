FROM python:3

COPY ./ /catchiorrineo
WORKDIR /catchiorrineo

RUN pip install -r requirements.txt
RUN pip install gunicorn

CMD [ "/catchiorrineo/start.sh" ]
