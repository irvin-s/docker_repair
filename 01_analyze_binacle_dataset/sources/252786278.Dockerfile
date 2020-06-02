FROM docker:stable  
COPY ./src /app  
CMD ["sh", "/app/update.sh"]

