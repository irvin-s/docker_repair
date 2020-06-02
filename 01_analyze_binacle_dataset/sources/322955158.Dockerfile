FROM python:2.7
LABEL maintaner="liming你好 394498036@qq.com"
COPY . /app
WORKDIR /app
RUN pip install flask redis
EXPOSE 5000
CMD [ "python", "app.py" ]
