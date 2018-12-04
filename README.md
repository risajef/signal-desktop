# signal-desktop
A docker image to run signal-desktop.

As Signal-Desktop is not available for CentOS but I need it I decided to solve this problem with docker.
Run these commands:

    docker build -t signal .


    docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $(pwd)/data:/home/developer/.config/Signal -v $(pwd)/share:/home/developer/share/ signal .

The content of "share" is then available inside the container and can be used to attach files to signal.
