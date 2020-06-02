FROM python:2.7
LABEL maintaner=" 欢迎关注公众号：编程坑田铎 394498036@qq.com"
COPY . /app
WORKDIR /app
RUN pip install flask redis
EXPOSE 5000
CMD [ "python", "app.py" ]
