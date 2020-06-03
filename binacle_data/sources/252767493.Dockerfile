FROM circleci/python:3.6.1  
COPY app.py requirements.txt ./  
RUN sudo pip install -r requirements.txt  
ENV work_dir /work  
RUN sudo mkdir -p $work_dir  
WORKDIR ${work_dir}  
RUN sudo chown -R circleci:circleci $work_dir && echo 'hoge' > $work_dir/hoge  

