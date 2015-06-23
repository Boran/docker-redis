Docker image of redis
- experimental phase
- 

# testing:
# Build image, calling it redis2
sudo docker build -t=redis2 .

# run a container from the image interactively, call it redis and delete it when it is stopped
sudo docker run -it --rm --name redis redis2

# Start redis on port 3000
sudo docker run -it -e REDIS_PORT=3000 --rm --name redis redis2

