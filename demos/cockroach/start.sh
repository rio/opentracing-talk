docker-compose up -d --scale=cockroach-node=4 cockroach-node
docker-compose run --rm cockroach-init
docker-compose ps
