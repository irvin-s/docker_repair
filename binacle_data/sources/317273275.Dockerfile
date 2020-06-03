FROM python:3-slim
LABEL maintainer="will835559313@163.com"
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
CMD [ "python", "main.py" ]