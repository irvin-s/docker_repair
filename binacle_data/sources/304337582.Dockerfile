FROM python:3.7
ARG KEY=default_key

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN touch config.py \
    && echo "secret_key = '$KEY'" >> config.py

COPY . .

CMD ["gunicorn", "app:app", "-c", "./gunicorn.conf.py"]