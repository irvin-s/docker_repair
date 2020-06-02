FROM python

RUN \
  apt-get update && \
  apt-get install -y nodejs && \
  rm -rf /var/lib/apt/lists/*


ADD requirements.txt /bot/
WORKDIR /bot
RUN pip install -r ./requirements.txt

ADD bot /bot

CMD ["python", "./main.py"]

EXPOSE 8080
