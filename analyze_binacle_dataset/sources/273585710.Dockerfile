
#Starter Dockerfile for Keras Deep Learning Projects

FROM python:3

RUN apt-get update && apt-get -y install apt-transport-https curl
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

##############################################################################################
#Install Microsoft ODBC drivers
RUN sudo su 
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/8/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN exit
RUN sudo apt-get install apt-transport-https
RUN sudo apt-get update
RUN sudo ACCEPT_EULA=Y apt-get install -y msodbcsql
# optional: for bcp and sqlcmd
#RUN sudo ACCEPT_EULA=Y apt-get install -y mssql-tools
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
#RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#RUN source ~/.bashrc
# optional: for unixODBC development headers
#RUN sudo apt-get install unixodbc-dev
###############################################################################################

#Install dependencies
RUN apt-get update && apt-get install -y gcc unixodbc-dev
RUN pip install nano 
RUN pip install pystrich
RUN pip install pandas
RUN pip install numpy
RUN pip install keras
RUN pip install pyodbc
RUN pip install tensorflow
RUN pip install sklearn
RUN pip install keras_tqdm
RUN pip install matplotlib
RUN pip install h5py
##############################################################################################
##Setting up Locale
RUN apt-get install -y locales

RUN echo "Europe/Oslo" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# nb_NO.UTF-8 UTF-8/nb_NO.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="en_US.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
###############################################################################################

#ADD starter-code.py /
#CMD [ "python", "./starter-code.py" ]


