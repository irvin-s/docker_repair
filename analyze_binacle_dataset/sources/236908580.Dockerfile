FROM python:3.7-alpine

RUN addgroup -g 1000 -S app && \
    adduser -u 1000 -S app -G app

WORKDIR /home/app/
USER 1000
ENV PATH=${PATH}:/home/app/.local/bin

COPY pyproject.toml poetry.lock /home/app/
RUN pip install --user poetry \
    && poetry install --no-dev

ADD . .
ENTRYPOINT ["poetry", "run", "/home/app/auth0connections.py", "-f", "/tmp/values.yaml"]
