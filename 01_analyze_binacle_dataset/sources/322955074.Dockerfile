FROM python:2.7
LABEL maintainer="liming<394498036@qq.com>"

COPY . /skeleton
WORKDIR /skeleton
RUN pip install -r requirements.txt
EXPOSE 5000
ENTRYPOINT ["scripts/dev.sh"]
