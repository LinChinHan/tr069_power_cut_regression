


help:
	@cat README.md


#Now platform is Ubuntu 
install:
	apt-get install -y \
		python-pip \
		python3-venv \
		python3-pip \
		docker.io \
		docker-compose
	pip3 install virtualenv

start:
	docker-compose up

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up
