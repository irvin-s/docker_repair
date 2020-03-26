# Image: jstubbs/abaco_test
# Simple image that echos the MSG environment variable for testing.
# from ubuntu:14.04
from busybox

add test.sh /test.sh
# add test_nosleep.sh /test.sh
run chmod +x /test.sh
CMD ["sh", "/test.sh"]
