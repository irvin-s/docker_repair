FROM python:2-onbuild  
EXPOSE 8000  
WORKDIR /opt  
RUN git clone https://github.com/chapeter/acimigrate  
WORKDIR acimigrate  
RUN sudo pip install -r requirements.txt  
CMD [ "python", "./main.py" ]  

