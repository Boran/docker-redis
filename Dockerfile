

FROM       centos:centos7
MAINTAINER Sean Boran <sean.boran@swisscom.com>


RUN groupadd -r redis && useradd -r -g redis redis

# todo: grab gosu for easy step-down from root
#RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
#RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture)" \
#        && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-$(dpkg --print-architecture).asc" \
#        && gpg --verify /usr/local/bin/gosu.asc \
#        && rm /usr/local/bin/gosu.asc \
#        && chmod +x /usr/local/bin/gosu

#ENV REDIS_VERSION      3.0.1
#ENV REDIS_DOWNLOAD_SHA1 fe1d06599042bfe6a0e738542f302ce9533dde88
ENV REDIS_VERSION       3.0.2
ENV REDIS_DOWNLOAD_SHA1 a38755fe9a669896f7c5d8cd3ebbf76d59712002
ENV REDIS_DOWNLOAD_URL  http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz


# for redis-sentinel see: http://redis.io/topics/sentinel
RUN buildDeps='gcc libc6-dev make tar sudo'; \
        set -x \
        && yum -y update && yum -y install $buildDeps \
        && mkdir -p /usr/src/redis \
        && curl -sSL "$REDIS_DOWNLOAD_URL" -o redis.tar.gz \
        && echo "$REDIS_DOWNLOAD_SHA1 *redis.tar.gz" | sha1sum -c - \
        && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
        && rm redis.tar.gz \
        && make -C /usr/src/redis \
        && make -C /usr/src/redis install \
        && rm -r /usr/src/redis 

#todo: clean up unused yum caches
#RUN yum -y install httpd; yum clean all; 

RUN echo "todo: Tuning of kernel for redis via sysctl, see https://github.com/docker/docker/issues/4717"
#RUN echo "vm.overcommit_memory=1" >> /etc/sysctl.conf
#echo never > /sys/kernel/mm/transparent_hugepage/enabled


RUN     mkdir /data && chown redis:redis /data
VOLUME  /data
WORKDIR /data

# Make sure we have a proper working terminal
ENV TERM xterm

COPY abstract_run.sh /abstract_run.sh

EXPOSE 6379
USER   redis
CMD    ["/bin/bash", "/abstract_run.sh"]

## ---
# defaults to pass to abstract_run.sh, can be overridden at run time
ENV REDIS_PORT 6379

