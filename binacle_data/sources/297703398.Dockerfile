FROM paddlepaddle/paddle:0.10.0rc2-gpu
ADD start.sh start_paddle.py fetch_trainerid.py /root/
ADD ./quick_start /root/quick_start
CMD ["bash","/root/start.sh"]
