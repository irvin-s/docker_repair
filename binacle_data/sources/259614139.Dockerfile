FROM python:3
ENV PYTHONUNBUFFERED 1
COPY pinder /pinder
EXPOSE 8000
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt;\
    python /pinder/manage.py migrate;\
    python /pinder/manage.py loaddata /pinder/users/fixtures/initial_data.json

ENTRYPOINT ["python", "/pinder/manage.py"]
