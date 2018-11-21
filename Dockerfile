FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    sudo


# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN apt update && apt install wget -y \
    apt-transport-https \
    chromium-browser \
    libasound2 \
    libgtk2.0-0 \
    libnss3-1d \
    libgconf2-4 \
    libxss1 \
    libxtst6
WORKDIR /home/developer
RUN wget https://updates.signal.org/desktop/apt/keys.asc -O /home/developer/key.asc && apt-key add /home/developer/key.asc
RUN echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | tee -a /etc/apt/sources.list.d/signal-xenial.list
RUN apt update && apt install signal-desktop -y


USER developer
ENV HOME /home/developer
CMD signal-desktop 
