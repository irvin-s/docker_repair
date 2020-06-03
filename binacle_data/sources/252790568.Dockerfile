FROM mesosphere/aws-cli  
  
COPY ./entrypoint.sh /project  
  
ENTRYPOINT [ "./entrypoint.sh" ]  

