FROM busybox
CMD ["chroot","/host_dir","/bin/sh"]
