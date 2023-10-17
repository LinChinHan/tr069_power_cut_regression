# tr069_power_cut_regression

## Environment parepare
The problem will be started by python. The program will be run by using virtual environemnt.
Below is repuirement package for using virtual environment.
```
apt-get install python-pip
apt-get install python3-venv
apt-get install docker.io
apt-get install docker-compose
```


## How to run test
python will control docker-compose to up/down the services.
```
python main.py
```

## The env folder is created:
```
python -m venv env
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



