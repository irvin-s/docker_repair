FROM python:3

RUN pip install --upgrade -e git+https://github.com/gpocentek/python-gitlab.git@master#egg=python-gitlab awesome-slugify
COPY deployer.py /

EXPOSE 8080
CMD ["python", "-u", "/deployer.py"]
