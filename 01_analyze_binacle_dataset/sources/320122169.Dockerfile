FROM docker.elastic.co/elasticsearch/elasticsearch:6.1.4

# Get wait-for-it-script
ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/e1f115e4ca285c3c24e847c4dd4be955e0ed51c2/wait-for-it.sh /utils/wait-for-it.sh

# Copy entrypoint and insert script
COPY entrypoint.sh ./
COPY insert_script.sh ./

# Make executable
USER root
RUN chmod +x ./entrypoint.sh
RUN chmod +x ./insert_script.sh

# Make runnable by elasticsearch user
RUN chmod 777 /utils/wait-for-it.sh

USER elasticsearch

CMD [ "./entrypoint.sh" ]