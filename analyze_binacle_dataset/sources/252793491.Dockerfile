FROM marcelocg/phoenix:latest  
  
RUN apt-get update && apt-get install -y postgresql-client  
  
COPY . /opt/app  
WORKDIR /opt/app  
RUN npm install  
RUN node_modules/brunch/bin/brunch build --production  
RUN mix local.hex --force  
RUN mix deps.get  
RUN mix compile  
  
ENV PORT 80  
EXPOSE 80  
COPY ./entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["mix", "phoenix.server"]

