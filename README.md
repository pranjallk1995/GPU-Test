## About
A small docker compose code snippet to check for access of GPU inside a tensorflow container running in WSL2.

# 2026 Prerequisites edit:

1. Install the Nvidia Drivers on Windows System.

2. Install some WSL2 Ubuntu distro.

     eg:
      check for available distro:
   
      ```wsl --list --online```
   
      install:
   
      `wsl --install Ubuntu`

3. Install Cuda toolkit into the WSL2 environment: https://developer.nvidia.com/cuda-downloads

     check:
      `nvidia-smi`

4. Install Docker engine: https://docs.docker.com/engine/install/ubuntu/

5. Install Nvidia Container toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html
   
     check: `nvidia-ctk -v`

6. ### Possibly optional (docker takes care of this automatically these days when you mention --gpus all):
   configure Nvidia runtime in deamon.json:
   
   generate the deamon.json file:
   
   `sudo nvidia-ctk runtime configure --runtime=docker`
   
   restart docker:
   
   `sudo systemctl restart docker`

7. Pull, Build, and Run a specific TensorFlow image or use the given compose file: `docker compose up`
   #### NOTE: Do not go for the latest TensorFlow image. CUDA support does not always exist. Also, no need to install CUDA and cuDNN in the WSL2 environment.
   
   eg:
   
   `sudo docker run -it --rm --gpus all tensorflow/tensorflow:2.16.1-gpu bash`
   
   or
   
   `sudo docker run -it --rm --gpus all nvcr.io/nvidia/tensorflow:24.11-tf2-py3 bash`
   
   check for GPU inside the container:
   
   `nvidia-smi`

8. Check for detection of GPU by Tensorflow:
    
    eg:
    
    `python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"`

Hope all that worked!....

PROOF:
<img width="1260" height="596" alt="image" src="https://github.com/user-attachments/assets/b71485a5-fd60-4f34-be67-be584d662d8f" />

Useful command for GPU monitoring:

install GPU stat from pip: `pip install gpustat`

put a watch on GPU usage: `watch gpustat`


<hr>

## Prerequisites (Deprecated):

1. Follow the guide to setup WSL2 settings:

   nvidia-docker2: https://docs.nvidia.com/cuda/archive/11.6.2/wsl-user-guide/index.html

   nvidia-container-toolkit: https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html

3. Make sure this library is installed in WSL:
   ```
   nvidia-docker2
   nvidia-container-toolkit
   ```
4. Make sure you have Nvidia Drivers installed in Windows.
5. Make sure you have CUDA installed in Windows.

## Steps:

1. Place the daemon.json in /etc/docker directory of WSL.

2. Do ``` docker compose up -d ``` in the location the docker-compose.yaml is placed.

3. Check if the container 'gpu-test' is healty via ``` watch docker ps ```

4. Attach to the container and check if tensorflow shows the GPU:
     1. ``` docker exec -it gpu-test bash ```
     2. do ``` python3 ``` to attach to python shell.
     3. ``` import tensorflow as tf ```
     4. ``` len(tf.config.list_physical_devices("GPU")) ```

5. Hope that this process works when you are follwing it -_-... always keeps changing...
6. EDIT: as always things changed and now use python base image and install using pip/uv tensorflow[and-cuda], keeping all other steps as the same. Till next edit!.. -_-
