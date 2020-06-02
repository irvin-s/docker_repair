FROM python:3.7

ARG UID=9000
ARG GID=9000

RUN groupadd -g $GID app \
 && useradd -u $UID -g $GID --no-create-home app

COPY --chown=app:app . /app
WORKDIR /app
RUN pip install -r requirements.txt

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT $SOURCE_COMMIT
USER app:app
CMD ["csbot", "csbot.cfg"]
