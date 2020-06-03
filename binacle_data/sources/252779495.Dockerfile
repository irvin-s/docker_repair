# 基础镜像  
FROM cairolee/racn-base  
  
# 维护人员  
MAINTAINER CairoLee "cairoliyu@gmail.com"  
# 复制入口脚本到指定目录  
COPY entrypoint.sh /data/  
  
# 赋予其可执行权限  
RUN chmod a+x /data/*.sh  
  
# 设置入口  
ENTRYPOINT ["/data/entrypoint.sh"]  

