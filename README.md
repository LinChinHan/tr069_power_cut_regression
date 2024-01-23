# tr069_power_cut_regression

## Introduction
This platform is "Ubuntu 18.04 LTS 64bits"
Using the python 3.69 for virtual environment.
You can install own python version >=3.6 and create virual environemnt by yourself
```
rm -rf env
python3 -m venv env
#Install necessary package after entering to virtual environment
source env/bin/activate
python -m pip install --upgrade pip
python -m pip install pyserial
python -m pip install paramiko
```

## Quick install
```
make install
```


##
## Environment parepare
The program will be started by python. The program will be run by using virtual environemnt.
Below is repuirement package for using virtual environment.
```
apt-get install python-pip
apt-get install python3-venv
apt-get install python3-pip

pip3 install virtualenv
apt-get install docker.io
apt-get install docker-compose
```


## How to run test
python will control docker-compose to up/down the services.
```
#Enter to virtual environment and run:
python main.py
```

## The env folder is created:
```
python3 -m venv env
```

## Command to enter to virual environment
```
source env/bin/activate
```

## Command to leave virtual environment
```
deactivate
```

## Command to install needed package in virtual environment
```
python -m pip install --upgrade pip
python -m pip install pyserial
python -m pip install paramiko
```


## docker start httpd server :
```
docker run -dit --name my-apache-app -p 80:80 -v "$PWD"/firmware/:/usr/local/apache2/htdocs/ httpd:2.4
```

## docker start i368 ubuntu:
```
docker run -dit --name ubuntu_32 -p 8080:8080 -v "${PWD}":/miniACS/ i386/ubuntu
```



