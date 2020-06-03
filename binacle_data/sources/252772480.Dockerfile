FROM python:2.7.13  
RUN mkdir -p /srv/avvo_question_suggester/current  
  
COPY . /srv/avvo_question_suggester/current  
  
WORKDIR /srv/avvo_question_suggester/current  
  
RUN pip install -r requirements.txt  
  
ENV REDIS_HOST localhost  
ENV REDIS_PORT 6379  
ENV REDIS_DB 0  
EXPOSE 8000  
RUN python /srv/avvo_question_suggester/current/setup.py install  
RUN python /srv/avvo_question_suggester/current/prepare.py  
  
ENTRYPOINT ["sh", "/srv/avvo_question_suggester/current/run.sh"]

