FROM python:2.7.11-alpine

RUN mkdir /checker
COPY checker.py /checker/checker.py

CMD [ "python", "-u", "/checker/checker.py" ]
