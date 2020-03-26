FROM python:3

ADD toDoBot.py /

RUN pip install discord.py

CMD [ "python", "./toDoBot.py" ]
