FROM python:2.7-onbuild
MAINTAINER Ignasi Barrera <ignasi.barrera@abiquo.com>

EXPOSE 8080
CMD ["python", "application.py"]
