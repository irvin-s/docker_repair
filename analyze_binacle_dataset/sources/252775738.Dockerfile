FROM python:3  
MAINTAINER dev@block79.com  
  
WORKDIR /app  
  
ADD . .  
  
RUN pip install -r requirements.txt  
RUN python -m spacy download en_core_web_sm  
RUN python -m spacy download xx_ent_wiki_sm  
  
EXPOSE 8000  
ENTRYPOINT python app.py

