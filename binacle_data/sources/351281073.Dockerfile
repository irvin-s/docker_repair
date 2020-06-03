# 时速云使用文档
# 使用时速云 [代码构建] 和 [持续集成]
# Version:2.0.0

FROM node
MAINTAINER TenxCloud Team <service@tenxcloud.com>

# Add files
RUN apt-get install git

RUN git clone https://github.com/tenxcloud/tenxcloud_doc

WORKDIR /tenxcloud_doc/docweb

# Install the dependencies modules
RUN npm install

# Expose ports
EXPOSE 3002

ADD run.sh /tenxcloud_doc/docweb/run.sh

RUN chmod +x run.sh

# Define default command.
CMD ["./run.sh"]