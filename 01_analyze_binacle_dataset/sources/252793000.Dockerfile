FROM node  
  
COPY . /opt/rna  
RUN git -C /opt/rna clean -Xdf \  
&& yarn global add /opt/rna  

