FROM python:2-alpine  
WORKDIR /usr/src/app  
COPY . .  
CMD [ "python", "./pophttp.py", "-vv"]

