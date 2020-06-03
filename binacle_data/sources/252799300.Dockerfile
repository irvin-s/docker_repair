FROM microsoft/azure-cli  
MAINTAINER Daniel Falkner <dafalkne@microsoft.com>  
COPY ./copyimage.sh /  
CMD /copyimage.sh

