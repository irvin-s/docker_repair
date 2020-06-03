FROM python

RUN python -m pip install grpcio

COPY *.py /app/

CMD ["python", "/app/Server.py"]
