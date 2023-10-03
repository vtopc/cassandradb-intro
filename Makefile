.PHONY: start
start:
	docker compose up -d

.PHONY: stop
stop:
	docker compose stop

.PHONY: shell
shell:
	docker run --rm -it --network cassandradb-intro_cassandra nuvo/docker-cqlsh cqlsh cassandra 9042 --cqlversion='3.4.5'
