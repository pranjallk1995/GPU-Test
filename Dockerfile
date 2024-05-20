FROM tensorflow/tensorflow:latest-gpu

RUN apt update -y && apt upgrade -y && apt install gpustat -y