FROM python:3-onbuild

RUN apt-get update
RUN apt-get install zip

CMD [ "./bootstrap.sh" ]
