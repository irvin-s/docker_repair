# Build docker
# docker build -t CONTAINERNAME .

# Run container (maps local port 80 to 80 in the container)
# docker run -p 80:80 -d CONTAINERNAME


FROM python:3.5-alpine

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN apk update
RUN apk add linux-headers g++
RUN pip3 install --no-cache-dir -r requirements.txt
RUN pip3 install gunicorn

COPY . .

CMD [ "gunicorn", "-b", "0.0.0.0:80", "wsgi:application" ]
