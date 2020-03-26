# Use an official Python runtime as a parent image  
FROM champsys/ubuntu-16-nodejs  
  
# Set the working directory to /app  
WORKDIR /home  
  
# Copy the current directory contents into the container at /app  
ADD . /home  
  
# Install any needed packages needed here  
# Make port 5000 available to the world outside this container  
EXPOSE 5000  
EXPOSE 5432  
# Define environment variable  
ENV NODE_ENV=production  
ENV IMPORT_SEED=true  
ENV POSTGRES_DATABASE=tyr_design_lab  
ENV POSTGRES_HOST=tyr-design-lab.csunyeskbxsy.us-west-2.rds.amazonaws.com  
ENV POSTGRES_USERNAME=designlab_admin  
ENV POSTGRES_PASSWORD=eyeofthetiger  
ENV DOTNET_URL=http://testcustom.champ-sys.com:9090/csservice.asmx?WSDL  
ENV DOTNET_APP=Altitude  
ENV DOTNET_PASSWORD=PhErere2ez8CReTR  
#ENV DOTNET_LOG=  
#ENV DOTNET_LANGUAGE_ID=  
ENV AWS_ACCESS_KEY=AKIAIV5WMJ2KUG7JMCEA  
ENV AWS_SECRET_KEY=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  
  
# Install project dependents  
RUN ln -s /root/.nvm/versions/node/v8.10.0/bin/node /usr/bin/node  
RUN ln -s /root/.nvm/versions/node/v8.10.0/bin/npm /usr/bin/npm  
RUN npm install  
  
# Run app.py when the container launches  
CMD ["/root/.nvm/versions/node/v8.10.0/bin/node", "server/app.js"]  

