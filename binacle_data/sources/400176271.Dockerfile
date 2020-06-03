FROM python:3.7
ADD . /code
WORKDIR /code
RUN pip install pipenv
RUN pipenv sync

CMD ["pipenv", "run", "python", "gulaschkanone.py", "-f", "/data/gpn19.json", "-p", "80"]
