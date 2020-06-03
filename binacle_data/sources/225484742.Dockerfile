ARG PYTHON_VERSION

FROM python:${PYTHON_VERSION}

WORKDIR /app

RUN apt-get -qq update \
  && apt-get upgrade -yq \
  && apt-get install -y libasound-dev \
    portaudio19-dev \
    libportaudio2 \
    libportaudiocpp0\
    ffmpeg \
    python-dev \
    libpq-dev \
    postgresql-client-9.6 \
  && apt-get autoremove \
  && apt-get clean \
  && pip install pipenv \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* /var/tmp/*

COPY Pipfile* /app/
RUN pipenv install
COPY ./ /app/

CMD ["tail", "-f", "/dev/null"]
