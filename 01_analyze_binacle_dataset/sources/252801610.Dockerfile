FROM python:3.6  
WORKDIR /app  
COPY . /app  
  
RUN pip3 install -r requirements.txt  
  
RUN useradd bot  
RUN chown bot .  
RUN chown bot tmp  
  
RUN chown bot run.py  
RUN mv secret.toml.sample secret.toml  
RUN chown bot secret.toml  
RUN chown bot cmd.sh  
RUN chmod +x cmd.sh  
  
USER bot  
CMD ./cmd.sh  
  

