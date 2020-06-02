FROM python:alpine  
  
LABEL maintainer "ullebe1@gmail.com"  
LABEL maintainer "jonastranberg93@gmail.com"  
  
# Set Timezone  
RUN apk add --no-cache tzdata  
ENV TZ=Europe/Copenhagen  
  
# Expose ports  
EXPOSE 80/tcp  
EXPOSE 80/udp  
EXPOSE 5000/tcp  
EXPOSE 5000/udp  
  
# Prepare app dir  
RUN mkdir -p /app/uploads /app/pictures  
WORKDIR /app  
  
# Copy flask application  
COPY templates ./templates  
COPY pictures ./pictures  
COPY dagensdatalog.py ./dagensdatalog.py  
COPY slogans.txt ./slogans.txt  
COPY requirements.txt ./requirements.txt  
  
# Install packages  
RUN pip install --no-cache-dir -r requirements.txt  
  
# Start app  
CMD [ "python", "dagensdatalog.py" ]  

