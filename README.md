Docker image of redis (experiment)

Testing
=======

Build image, calling it redis2
------------------------------

sudo docker build -t=redis2 .


Create a container
------------------

Run a container from the image interactively, call it redis and delete it when it is stopped

sudo docker run -it --rm --name redis redis2

Start redis on port 3000

sudo docker run -it -e REDIS_PORT=3000 --rm --name redis redis2


Issues
------

- Add option to pass any redis commandline option to the ENV (easy)
- Kernel tuning with sysctl (docker limitation)
- Think about data storage
