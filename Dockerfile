FROM centos:7

RUN groupadd -r redis && useradd -r -g redis redis

ENV REDIS_VERSION 3.0.1
ENV REDIS_DOWNLOAD_URL http://download.redis.io/releases/redis-3.0.1.tar.gz
ENV REDIS_DOWNLOAD_SHA1 fe1d06599042bfe6a0e738542f302ce9533dde88

#RUN yum -y install httpd; yum clean all; 

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
#        && apt-get purge -y --auto-remove $buildDeps

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server" ]
