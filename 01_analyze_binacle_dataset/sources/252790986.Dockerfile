FROM python:3.5  
# create a directory and change working directory  
WORKDIR /src  
# copy requirements file to the working directory  
ADD src/requirements.txt requirements.txt  
# install packages in the requirements file  
RUN pip install -r requirements.txt  
# Set the timezone  
RUN echo "Asia/Tokyo" > /etc/timezone  
RUN dpkg-reconfigure -f noninteractive tzdata  
# copy project directory  
ADD src /src  
# expose 8000 port on the container  
# set environment variables  
ENV PYTHONUNBUFFERED=1 \  
DATABASE_HOST=db \  
DATABASE_NAME=postgres \  
DATABASE_USER=postgres \  
DATABASE_PASSWORD=postgres \  
FRONTEND_IP=localhost:8080  
EXPOSE 8000  
# for kubernetes  
RUN mkdir /shared-volume  
ENTRYPOINT ["bash", "/src/init.sh"]  

