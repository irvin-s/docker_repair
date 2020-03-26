FROM dockerfile/python  
MAINTAINER dsociative  
  
  
EXPOSE 843  
ADD ./ /policy_caster  
RUN python /policy_caster/setup.py install  
ENV PYTHONPATH /policy_caster  
  
CMD ["policy_caster"]  

