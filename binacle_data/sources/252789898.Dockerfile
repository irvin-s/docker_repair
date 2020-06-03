FROM ruby:2.2.3-slim  
ADD translator.rb ./  
ADD yorkshire.yml ./  
ADD geordie.yml ./  
ADD scouse.yml ./  
ENTRYPOINT [ "ruby", "translator.rb" ]

