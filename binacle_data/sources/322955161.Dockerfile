FROM python:2.7
LABEL maintaner="liming 394498036@qq.com"
COPY . /app
WORKDIR /app
RUN pip install flask redis
EXPOSE 80
CMD [ "python", "app.py" ]