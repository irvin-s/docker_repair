FROM python

RUN pip install flask redis

WORKDIR /

COPY app.py /

EXPOSE 5000

CMD python app.py
