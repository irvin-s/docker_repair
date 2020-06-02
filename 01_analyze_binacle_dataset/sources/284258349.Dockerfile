FROM python:2.7

ENV REFRESHED_AT 2017-04-24T13:50

COPY simple-service simple-service

RUN cd simple-service && python setup.py develop

CMD [ "python", "./simple-service/simple_service.py" ]
