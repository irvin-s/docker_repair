FROM python:2-alpine

COPY requirements.txt /usr/src/app/
WORKDIR /usr/src/app
RUN pip install -r requirements.txt

COPY script.py /usr/src/app/
RUN chmod +x script.py
CMD ["python", "/usr/src/app/script.py"]
