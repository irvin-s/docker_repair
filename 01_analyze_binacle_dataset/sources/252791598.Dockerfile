# Stage 0 - Node build  
FROM node:8  
WORKDIR /kerckhoff  
ENV DEBUG False  
ADD package.json package-lock.json /kerckhoff/  
RUN npm i  
COPY ./webpack.config.js ./jsconfig.json ./  
COPY ./kerckhoff/assets ./kerckhoff/assets  
RUN npm run build  
  
# Stage 1 - Python dependencies  
FROM python:3-slim  
ENV PYTHONUNBUFFERED 1  
RUN mkdir /kerckhoff  
  
RUN apt-get update && apt-get install -y curl \  
build-essential  
  
WORKDIR /kerckhoff  
  
ADD requirements.txt /kerckhoff/  
RUN pip install -r requirements.txt  
  
# Get the webpack built assets from the previous stage  
COPY \--from=0 /kerckhoff /kerckhoff  
  
ADD . /kerckhoff/  
EXPOSE 5000  
ENTRYPOINT [ "./prod-entrypoint.sh" ]  
CMD "./prod.sh"

