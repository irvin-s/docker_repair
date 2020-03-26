# Use an official Python runtime as a parent image  
FROM python:3.5-slim  
  
# Set the working directory to /app  
WORKDIR /app  
  
# Install any needed packages specified in requirements.txt  
ADD requirements.txt ./requirements.txt  
RUN pip install -r requirements.txt  
  
# Copy the current directory contents into the container at /app  
ADD . /app  
  
# Define environment variable  
ENV AZURE_TENANT_ID {PUT_AZURE_TENANT_ID_HERE}  
ENV AZURE_CLIENT_ID {PUT_AZURE_CLIENT_ID_HERE}  
ENV AZURE_CLIENT_SECRET {PUT_AZURE_CLIENT_SECRET_HERE}  
ENV AZURE_SUBSCRIPTION_ID {PUT_AZURE_SUBSCRIPTION_ID_HERE}  
  
# Run example.py when the container launches  
CMD ["python", "AzureKeyVaultSecretService.py"]

