FROM ruby:slim  
RUN gem install aws-ssm-console  
ENTRYPOINT ["aws-ssm-console"]  

