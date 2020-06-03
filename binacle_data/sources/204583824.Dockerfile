FROM python:2.7.11-onbuild
MAINTAINER Michael Hausenblas "michael.hausenblas@gmail.com"
ENV REFRESHED_AT 2016-04-02T09:54
EXPOSE 9999
CMD [ "python", "./fob_dispatcher.py" ]