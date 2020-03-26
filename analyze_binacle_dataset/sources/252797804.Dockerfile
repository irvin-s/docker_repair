FROM cocoon/pyrun  
  
  
# Add the Flask App  
ADD . /src  
  
# EXPOSE PORT  
EXPOSE 5000  
# Run the Flask APP  
CMD python /src/app.py  

