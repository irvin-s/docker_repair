FROM frolvlad/alpine-python3

RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app
COPY requirements.txt .

RUN apk update && \
    apk add postgresql-libs python3-dev && \
    apk add --virtual .build-deps gcc musl-dev postgresql-dev libffi-dev && \
    pip install -r requirements.txt --no-cache-dir && \
    apk --purge del .build-deps


# default flask server 
# EXPOSE 5000
# CMD ["python3", "manage.py", "run"]

# gunicorn
RUN mkdir -p /usr/logs && chmod 777 /usr/logs
EXPOSE 8000
ENTRYPOINT ["gunicorn", "wsgi:app"]
CMD ["--capture-output"]
