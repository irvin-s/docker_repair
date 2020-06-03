FROM ruby:2.3  
ENV RACK_ENV production  
  
COPY app /app  
  
WORKDIR /app  
  
RUN bundle  
  
EXPOSE 80  
CMD ["sh", "-c", "puma -C /app/puma.rb"]  

