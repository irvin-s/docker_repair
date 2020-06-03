FROM ruby:2.4.2  
  
RUN apt-get update && \  
apt-get install -y net-tools  
  
# Set locale  
ENV LANG C.UTF-8  
  
# Install gems  
RUN mkdir /app  
WORKDIR /app  
COPY Gemfile* /app/  
RUN bundle install  
  
# Upload source  
COPY . /app  
  
RUN useradd ruby  
RUN chown -R ruby /app  
USER ruby  
  
# Database defaults  
ENV DATABASE_NAME print_production  
ENV DATABASE_HOST database  
ENV DATABASE_USER root  
ENV DATABASE_PASSWORD password  
  
# Start server  
ENV RAILS_ENV production  
ENV RACK_ENV production  
ENV SECRET_KEY_BASE secret  
ENV PORT 3000  
EXPOSE 3000  
  
CMD ["sh", "start.sh"]  

