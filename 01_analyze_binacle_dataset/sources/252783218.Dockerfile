FROM dclong/python  
  
RUN apt-get install -y pelican  
  
RUN cd /scripts \  
&& git clone https://github.com/dclong/python-blog.git \  
&& ln -s /scripts/python-blog/blog.py /usr/local/bin/blog \  
&& git clone https://github.com/dclong/vim.git  
  
RUN mkdir /blog && chmod 777 /blog \  
&& mkdir /ssh && chmod 777 /ssh  
ENV blog_dir /blog  
WORKDIR /blog  
  
COPY settings/gitconfig /etc/gitconfig  
COPY settings/gitignore /etc/gitignore  
COPY settings /settings  
COPY scripts /scripts  

