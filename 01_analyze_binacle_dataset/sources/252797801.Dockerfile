FROM cocoon/droyd  
MAINTAINER cocoon  
  
  
EXPOSE 5000  
CMD droydserve --host 0.0.0.0 --port 5000

