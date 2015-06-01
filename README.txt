Docker image of redis
- based on https://github.com/docker-library/redis.git, but adapted for centos

# testing:
docker build -t=redis2 .
docker run -it --name redis redis2

