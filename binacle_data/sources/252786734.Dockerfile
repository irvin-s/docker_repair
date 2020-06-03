# Docker multi-stage build file  
# Requires docker 17.05 or newer.  
##  
##  
FROM ruby:2.3 as builder  
  
WORKDIR /app  
  
COPY Gemfile* ./  
RUN bundle install --frozen --deployment  
  
COPY *.rb ./  
RUN bundle exec street_cleaning.rb  
  
##  
##  
FROM nginx:alpine  
  
EXPOSE 80  
# A configuration for serving just our calendar.ics  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
  
# Our streetcleaning ics file.  
COPY \--from=builder /app/calendar.ics /usr/share/nginx/html/  
  
# Remove default index.html file.  
RUN rm -f /usr/share/nginx/html/index.html  
  
# vim: ft=dockerfile :  

