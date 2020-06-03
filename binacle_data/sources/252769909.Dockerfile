FROM python:stretch  
  
# Clone the code and set the workdir  
# RUN git clone https://github.com/Aurorastation/IconDiffBot /app  
ADD . /app  
WORKDIR /app  
  
# Install dependencies  
RUN pip install -r requirements.txt  
  
EXPOSE 1236  
CMD ["python", "pr_icon_differ.py"]  

