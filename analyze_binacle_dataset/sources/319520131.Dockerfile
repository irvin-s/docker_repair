FROM python:3.6
MAINTAINER tiaod<tiaod@qq.com>

COPY ./requirements.txt /src/requirements.txt
RUN pip install -U -r /src/requirements.txt

EXPOSE 5000

COPY . /src

WORKDIR /src

CMD ["gunicorn", "app:app", "--workers=4", "--bind=0.0.0.0:5000"]
