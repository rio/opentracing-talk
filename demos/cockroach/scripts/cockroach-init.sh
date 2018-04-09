# ./cockroach init --insecure
./cockroach gen example-data startrek | ./cockroach sql --insecure --verbosity 0

./cockroach sql --insecure -e "ALTER TABLE startrek.episodes SPLIT AT VALUES (40), (80), (120), (160)"
./cockroach sql --insecure -e "ALTER TABLE startrek.quotes   SPLIT AT VALUES (40), (80), (120), (160)"

./cockroach sql --insecure -e "SHOW TESTING_RANGES FROM TABLE startrek.quotes"
./cockroach sql --insecure -e "SHOW TESTING_RANGES FROM TABLE startrek.episodes" 

./cockroach sql --insecure -e "SET CLUSTER SETTING trace.zipkin.collector='jaeger:9411'"
./cockroach sql --insecure -e "SET TRACING = cluster"