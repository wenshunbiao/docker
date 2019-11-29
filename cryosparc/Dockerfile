FROM nvidia/cuda:8.0-cudnn5-devel

RUN apt update
RUN apt-get install -y curl wget

RUN echo 'XKBMODEL="pc105" \n XKBLAYOUT="us" \n  XKBVARIANT="intl" \n XKBOPTIONS="" \n BACKSPACE="guess"' > /etc/default/keyboard

RUN apt-get install nvidia-375
