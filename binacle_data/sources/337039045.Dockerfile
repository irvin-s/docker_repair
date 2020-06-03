FROM python:3.6.5
WORKDIR /tmp
copy ./junkins.py /tmp/
copy ./plain_postdata /tmp/
RUN pip install requests
ENTRYPOINT ["python",  "/tmp/junkins.py"]
