FROM alpine:3.8

LABEL authors="zhwei"

WORKDIR /root

RUN echo 'https://mirrors.aliyun.com/alpine/v3.8/main' > /etc/apk/repositories \
    && echo 'https://mirrors.aliyun.com/alpine/v3.8/community' >> /etc/apk/repositories \
    && apk add --no-cache rsync g++ \
    && apk add --no-cache --virtual .build-tools make \
    # Install thrift
    && cd /root \
    && wget https://mirrors.tuna.tsinghua.edu.cn/apache/thrift/0.11.0/thrift-0.11.0.tar.gz \
    && tar zxvf thrift-0.11.0.tar.gz \
    && cd thrift-0.11.0/ \
    && ./configure --without-nodejs --without-python --without-cpp \
    && make -j8 \
    && make install \
    && ln -s /usr/local/bin/thrift /usr/bin/thrift \
    && rm -rf /root/* \
    # Install fswatch
    && cd /root \
    && wget https://github.com/emcrisostomo/fswatch/releases/download/1.9.1/fswatch-1.9.1.tar.gz \
    && tar zxvf fswatch-1.9.1.tar.gz \
    && cd fswatch-1.9.1 \
    && ./configure && make -j8 \
    && make install \
    && rm -rf /root/* \
    # clean
    && apk del .build-tools
