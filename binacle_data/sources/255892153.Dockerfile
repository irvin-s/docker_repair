FROM zhuanxuhit/hadoop
LABEL name="zhuanxu <893051481@qq.com>"

CMD ["/usr/local/hadoop/sbin/hadoop-daemon.sh start journalnode"]