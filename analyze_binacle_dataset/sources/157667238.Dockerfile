FROM nginx

ENV HOME /root

VOLUME ["/mysql_data"]

ADD /mysql_data /mysql_data
# Define default command.
CMD ["bash"]

