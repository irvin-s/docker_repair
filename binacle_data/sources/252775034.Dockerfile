FROM ruby:2.2-onbuild  
EXPOSE 4567  
CMD ["ruby", "premailer-api.rb", "-o", "0.0.0.0"]  

