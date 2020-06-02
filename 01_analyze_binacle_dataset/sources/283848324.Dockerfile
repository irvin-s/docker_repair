FROM gorialis/discord.py:alpine-master

WORKDIR /app
ADD . /app

RUN pip install -r requirements.txt

CMD ["python", "run.py"]
