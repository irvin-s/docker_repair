FROM python:3.5

COPY . /app
WORKDIR /app

RUN pip3 --no-cache-dir install pipenv

# At the time of writing, Pipenv can't find a configuration that satisfies all
# dependecy requirements. Because of that no Pipfile.lock is supplied and
# --skip-lock is used.
RUN pipenv install --system --skip-lock

CMD ["bash"]
