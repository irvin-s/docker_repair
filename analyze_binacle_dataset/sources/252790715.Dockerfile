FROM python  
WORKDIR /wd  
COPY requirements.txt /wd/  
RUN pip install -r requirements.txt  
COPY main.py /wd/  
ENTRYPOINT ["python","main.py"]  
EXPOSE 80  
ENV HTTP_PORT 80  
ENV SLEEP_RECORD 1  
ENV SLEEP_MERGER 60  
CMD [""]  

