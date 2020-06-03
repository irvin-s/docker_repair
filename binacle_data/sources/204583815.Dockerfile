FROM python:2.7.11-onbuild
MAINTAINER Michael Hausenblas "michael.hausenblas@gmail.com"
ENV REFRESHED_AT 2016-04-02T18:55
EXPOSE 9999
CMD [ "python", "./fob_driver.py" ]