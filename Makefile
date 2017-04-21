build:
	docker build -t dummyapp ./dummyapp/
	docker build -t helper ./helper/

start: start-helper start-dummyapp

stop: stop-dummyapp stop-helper

test:
	echo Starting monitor scripts
	curl --silent http://localhost:8080/slow-request.php > /tmp/slow-request-ouput.txt &
	curl --silent http://localhost:8080/ab.php > /tmp/ab.txt &
	echo Redeploying the service
	make redeploy-dummyapp
	echo Redeploy initiated
	echo Follow the output of the files at /tmp/slow-request-ouput.txt and /tmp/ab.txt
	echo use "make stop" once you have the data you need

setup:
	docker network create -d overlay dummynet

start-dummyapp: stop-dummyapp 
	docker service create --name dummyapp --network dummynet --publish 80:80 \
            --replicas 2 \
            --env APPLICATION_VERSION=1 \
	    --stop-grace-period=30s \
            dummyapp

redeploy-dummyapp:
	docker service update --update-parallelism 2 --env-add APPLICATION_VERSION=2 dummyapp

stop-dummyapp:
	docker service rm dummyapp ||:


start-helper: stop-helper
	docker service create --name helper --network dummynet --publish 8080:80 helper

stop-helper:
	docker service rm helper ||:

clean: stop
	docker network rm dummynet ||:
	docker rmi dummyapp ||:
	docker rmi helper ||:

PHONY: build start stop test setup start-dummyapp redeploy-dummyapp stop-dummyapp start-helper stop-helper clean 
