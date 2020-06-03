FROM ruby:2.3.3  
#  
RUN apt-get update && apt-get install -y \  
#Packages  
net-tools \  
nodejs  
  
#Install gems  
RUN mkdir /app  
WORKDIR /app  
COPY Gemfile* /app/  
RUN bundle install  
  
#Upload source  
COPY . /app  
RUN useradd ruby  
RUN chown -R ruby /app  
USER ruby  
  
# Database defaults  
ENV DATABASE_NAME db_name  
ENV DATABASE_HOST db_host  
ENV DATABASE_USER db_user  
ENV DATABASE_PASSWORD db_pass  
  
# Start server  
ENV RAILS_ENV production  
ENV RACK_ENV production  
ENV SECRET_KEY_BASE secret  
ENV PORT 3000  
EXPOSE 3000  
  
CMD ["sh", "start.sh"]  

