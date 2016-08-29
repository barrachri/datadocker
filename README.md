# DataDocker

__DataDocker__ is a (docker image)[link here] with a collections of packages to have a ready environment with a lot of stuff.

Based on Ubuntu Xenial

## Command to build the IMAGE
__sh build_data_docker.sh__ $PYTHON_VERSION

* $PYTHON_VERSION is the PYTHON_VERSION of your image, must must 2 or 3

## Command to run the CONTAINER
__sh run_data_docker.sh__ $LOCAL_FOLDER_NAME $PYTHON_VERSION

* $LOCAL_FOLDER_NAME is the path to the directory that you want to mount with "/home/datadocker" inside your container
* $PYTHON_VERSION, as above

You can see the running container with
* sudo docker ps

and stop the container with
* sudo docker stop CONTAINER_ID

**Main and only requirement:**

(__docker__)[https://docs.docker.com/engine/installation/]
