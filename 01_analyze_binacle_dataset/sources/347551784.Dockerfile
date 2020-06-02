FROM python:alpine

COPY . /opt/mdweb

WORKDIR /opt/mdweb

RUN ["pip", "install", "-r", "/opt/mdweb/requirements/test.txt"]
RUN ["mkdir", "-p", "coverage"]

EXPOSE 5000

CMD ["nosetests", "--with-coverage", "--cover-erase", "--cover-html", "--cover-html-dir=coverage/html", "--with-xunit", "--xunit-file=coverage/nosetests.xml", "--cover-package=mdweb"]
