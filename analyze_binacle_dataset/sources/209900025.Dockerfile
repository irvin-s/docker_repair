FROM jwineinger/caffe-open-nsfw:latest

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qy --no-install-recommends socat

CMD ["socat", "tcp-l:80,reuseaddr,fork", "system:'read -r line; ls \"$line\" >&2; cd /workspace/open_nsfw; python ./classify_nsfw.py  --model_def nsfw_model/deploy.prototxt  --pretrained_model nsfw_model/resnet_50_1by2_nsfw.caffemodel \"$line\" 2> /dev/null | tee /dev/stderr | grep NSFW.score | sed \"s/^NSFW score:\\\\s*//\"'"]
