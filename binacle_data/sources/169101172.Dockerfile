FROM python:3.6
MAINTAINER ADI <infrastructure@adicu.com>

RUN pip install -U pipenv

WORKDIR /density
COPY ./Pipfile ./Pipfile
COPY ./Pipfile.lock ./Pipfile.lock
RUN pipenv install --ignore-pipfile --deploy

# add the application directories
COPY ./ ./

# expose the port and start the server
EXPOSE 6002
CMD /bin/bash -c "pipenv run gunicorn density:app \
        --bind 0.0.0.0:6002 \
        --log-level debug \
        --capture-output"
