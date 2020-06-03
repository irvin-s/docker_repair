# 用於註解
# 後續的流程, 前面都要大寫
# FROM 基於那個 image
FROM opensuse:42.1
# MAINTAINER 維護作者
# MAINTAINER Max Huang < sakana@study-area.org >
# MAINTAINER 方式目前已經棄用, 現在使用 LABEL 方式
LABEL maintainer="Max Huang <sakana@study-area.org>"
# RUN 要執行的指令
# 每一行就是一個 image layer, 儘量將同一種行為放同一行 使用 && 來連接
RUN zypper -n install openssh
