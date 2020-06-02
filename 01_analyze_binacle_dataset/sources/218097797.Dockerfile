FROM inikolaev/alpine-python:latest

RUN pip3 install pybuilder

ENTRYPOINT ["pyb"]
CMD ["--version"]
