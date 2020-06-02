FROM webratio/ant  
  
RUN ant -f ${ANT_HOME}/fetch.xml -Ddest=system  

