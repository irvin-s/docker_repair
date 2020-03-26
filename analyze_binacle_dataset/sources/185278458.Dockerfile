FROM python:3 as dist

WORKDIR /srv/http/melange
COPY setup.py ./
COPY melange ./melange
RUN python setup.py sdist \
 && mkdir ./pkg \
 && tar -C pkg/ -xf ./dist/Melange-*.tar.gz

FROM python:3

WORKDIR /srv/http/melange
VOLUME /var/lib/melange

ENV MELANGE_CONFIG_ENVIRON "yes"
ENV SECRET_KEY ""
ENV DATABASE_URL "sqlite:////var/lib/melange/melange.db"

COPY entrypoint.sh ./
ENTRYPOINT ["./entrypoint.sh"]

CMD ["gunicorn", "--bind=0.0.0.0:8000", "--workers=4", "--capture-output", "--log-file=-" ,"--access-logfile=-", "melange:app"]
EXPOSE 8000

RUN pip install --no-cache-dir gunicorn

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY --from=dist /srv/http/melange/pkg/Melange-1.0/melange/ ./melange/
