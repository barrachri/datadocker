#! /bin/bash

PYTHON=$1

if [ -z "$PYTHON" ]
then
  echo "No argument supplied, please indicate which version of Python, 2 or 3";
  exit 128;
elif (($PYTHON==2 || $PYTHON==3))
then
	docker build -t datadocker_image_python_$PYTHON -f dockerfile_dir/python_$PYTHON/Dockerfile;
else
	echo "The argument supplied should be a valid Python version, 2 or 3";
  exit 128;
fi
