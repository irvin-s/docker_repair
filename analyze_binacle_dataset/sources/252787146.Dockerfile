FROM brcomconcretesolutions/jenkins-slave  
  
USER root  
  
USER jenkins  
  
#setting up git plugin  
COPY buildbitbucketplugin.txt /buildbitbucketplugin.txt  
RUN plugins.sh buildbitbucketplugin.txt

