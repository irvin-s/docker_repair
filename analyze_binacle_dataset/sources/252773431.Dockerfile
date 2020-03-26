FROM google/cloud-sdk  
  
# I use 'none' as project ID because I do not mind the project to run  
# the datastore emulator.  
#ENV CLOUDSDK_CORE_PROJECT=test  
# This will allow (in the future) to place data in the desired location  
#VOLUME ...  
EXPOSE 8603  
ENTRYPOINT ["gcloud", "beta", "emulators", "datastore", "start"]  

