## About
A small docker compose code snippet to check for access of GPU inside a tensorflow container running in WSL2.

## Prerequisites:

1. Follow the guide to setup WSL2 settings:
https://docs.nvidia.com/cuda/archive/11.6.2/wsl-user-guide/index.html

2. Make sure these library are installed:
   ```
   nvidia-docker2
   ```

## Steps:

1. Place the daemon.json in /etc/docker directory of WSL .

2. Do ``` docker compose up -d ``` in the location the docker-compose.yaml is placed.

3. Check if the container 'gpu-test' is healty via ``` watch docker ps ```

4. Attach to the container and check if tensorflow shows the GPU:
     1. ``` docker exec -it gpu-test bash ```
     2. do ``` python3 ``` to attach to python shell.
     3. ``` import tensorflow as tf ```
     4. ``` len(tf.config.list_physical_devices("GPU")) ```

5. Hope that this process works when you are follwing it -_-... always keeps changing...
