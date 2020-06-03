FROM python:3.5.2
ADD requirements.txt /requirements.txt
RUN pip install --upgrade -r requirements.txt
ADD base.py /
ADD twitch.py /
CMD ["python3", "twitch.py"]
