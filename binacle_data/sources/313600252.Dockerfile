FROM python:3-alpine
ENV REGISTRY_URL=''

WORKDIR /usr/src/app
COPY venv-requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENTRYPOINT [ "/usr/src/app/entrypoint.sh" ]
