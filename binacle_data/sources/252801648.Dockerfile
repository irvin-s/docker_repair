FROM python:2  
COPY . /srv/  
  
WORKDIR /srv  
  
RUN pip install -r requirements.txt  
  
EXPOSE 9020  
CMD ["python", "spotify_token_swap.py"]  

