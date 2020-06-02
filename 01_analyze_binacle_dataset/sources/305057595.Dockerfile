FROM python:slim

RUN apt update && apt install -y nodejs

COPY ./requirements.txt /wenshu_utils/
WORKDIR /wenshu_utils
RUN pip install --no-cache-dir -r requirements.txt pytest -i https://pypi.douban.com/simple

COPY . /wenshu_utils

ENTRYPOINT ["pytest"]