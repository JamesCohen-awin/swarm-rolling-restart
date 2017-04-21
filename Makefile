build:
	docker build -t dummyapp ./dummyapp/
	docker build -t helper ./helper/

setup:
	docker network create -d overlay dummynet

start-dummyapp: stop-dummyapp 
	docker service create --name dummyapp --network dummynet --publish 80:80 \
            --replicas 2 \
            --env APPLICATION_VERSION=1 \
            dummyapp

redeploy-dummyapp:
	docker service update --env-add APPLICATION_VERSION=2 dummyapp

stop-dummyapp:
	docker service rm dummyapp ||:


start-helper: stop-helper
	docker service create --name helper --network dummynet --publish 8080:80 helper

stop-helper:
	docker service rm helper ||:

clean: stop-dummyapp
	docker network rm dummynet ||:
	docker rmi dummyapp ||:
	docker rmi helper ||:

PHONY: build start-dummyapp redeploy-dummyapp setup stop-dummyapp clean
