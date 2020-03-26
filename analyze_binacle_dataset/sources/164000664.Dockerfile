FROM python:3

ADD ./monospace-django/ /root/monospace-django
WORKDIR /root/monospace-django

EXPOSE 8000

RUN pip install -r requirements.txt
#RUN python monospace/manage.py syncdb
#CMD python monospace/manage.py runserver
CMD python -m http.server