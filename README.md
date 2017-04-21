# Graceful shutdown and rolling up date with Docker Swarm

To try it out.

 * Make sure your host is running in swarm mode (if not `docker swarm init`)
 * `make setup` to create the overlay network
 * `make build` to build the images
 * `make start` to startup the services
 * wait for them to start-up (use `docker ps` to monitor)
 * `make test` to test and then look for the files in `/tmp/*.txt`

before running `make test` again you'll need to do a `make start`

when you're totally done `make clean` to remove all traces (including the images and network)
