FROM python:3

RUN pip install -e git+https://github.com/murrayo/yape.git#egg=yape

ENTRYPOINT ["yape"]
CMD [ "-h" ]
