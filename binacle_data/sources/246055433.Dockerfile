FROM python:3.7.3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY requirements.txt server.py ./

EXPOSE 3000

CMD gunicorn --log-level warning --bind 0.0.0.0:3000 --reuse-port --workers $(nproc) --worker-class meinheld.gmeinheld.MeinheldWorker server:app
