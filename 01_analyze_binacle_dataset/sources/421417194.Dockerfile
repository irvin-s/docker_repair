ARG PYTHON_TAG=3.6.5-alpine3.7

# Builder image
FROM python:${PYTHON_TAG} AS builder
RUN apk add --no-cache \
        linux-headers \
        gettext-dev \
        postgresql-dev \
        gcc \
        musl-dev \
        pcre-dev
RUN mkdir /wheels
WORKDIR /wheels
COPY requirements.txt /wheels/requirements.txt
RUN pip wheel -r requirements.txt

# Workspace image
FROM alpine:3.7 AS workspace
ARG PROJECT_NAME=teerace
ENV PROJECT_NAME ${PROJECT_NAME}

RUN mkdir -p /code/static
ADD ${PROJECT_NAME} /code/${PROJECT_NAME}
ADD tests /code/tests
ADD setup.cfg entrypoint.sh /code/

# Final image
FROM python:${PYTHON_TAG}
ARG PROJECT_NAME=teerace
ENV PYTHONUNBUFFERED 1
ENV PROJECT_NAME ${PROJECT_NAME}
ENV RAVEN_RELEASE ${RAVEN_RELEASE}
ENV GIT_COMMIT ${GIT_COMMIT}

RUN apk add --no-cache \
        libpq \
        pcre \
        gettext
COPY --from=builder /wheels /wheels
RUN pip install \
        -r /wheels/requirements.txt \
        -f /wheels \
    && rm -rf /wheels \
    && rm -rf /root/.cache/pip
RUN addgroup -S app \
    && adduser -S -G app app
RUN mkdir /code
WORKDIR /code
COPY --chown=app:app --from=workspace /code /code
USER app
WORKDIR /code/${PROJECT_NAME}/
RUN python manage.py collectstatic --noinput

ENTRYPOINT ["../entrypoint.sh"]
