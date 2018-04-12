# opentracing-talk

View the presentation on [gitpitch.com/Rio/opentracing-talk](https://gitpitch.com/Rio/opentracing-talk)

# Demo's

Below you can find the instructions on starting and playing with the demo's yourself.
The only thing you need to have installed is docker and docker-compose.
The compose files are located in the `demos` directory.

## Hotrod

[Hotrod](https://github.com/jaegertracing/jaeger/tree/master/examples/hotrod) is Uber's example application that is packaged with the [Jaeger](https://jaegertracing.io) tracer that they've opensourced.
Step into `demos/hotrod` and run `docker-compose up` to start up Jaeger and the Hotrod application.
Jaeger will be accessible through your browser via `localhost:16686` and Hotrod via `localhost:8080`.
Fire off some requests and examine the traces it produces. Look at the Hotrod code and make some adjustments to see how it affects the traces.
A good place to start is to look at the latency that the mysql lock is producing when the number of concurrent requests go up. Another one is looking at the code that calls `GetDriver` and see if you can speed it up.

## Machinery

[Machinery](https://github.com/RichardKnop/machinery) is a library that helps with sending and processing background jobs using a queuing system like Redis or RabbitMQ. This demo will run the example script that simply sends
a number of tasks to the queue that show the different kinds of job compositions that machinery currently supports.
Step into `demos/machinery` and start everything up using `docker-compose up`. To send the tasks to the queue use `docker-compose run --rm machinery send`.
The results of those tasks are printed and then the container exits. Take a look at Jaeger on `localhost:16686` to see the trace that it produced.

## Cockroach

[Cockroach](https://cockroachlabs.com) is a highly available and consistent distributed database that supports ACID transactions.

In this demo we're going to:
- start 3 cockroach nodes that form a single cluster
- insert some example data
- split the tables so that cockroach will spread it out a bit more for demoing purposes
- enable tracing
- do an SQL query against those tables.

Step into `demos/cockroach` and start the cluster with `docker-compose up -d --scale=cockroach-node=2 cockroach-node`. After this the cockroach admin ui should be accessible through `localhost:8080` and it should show 3 nodes.
Now we're going to insert some example data, split that data up into multiple ranges for this demo and enable tracing in the cluster. Run `docker-compose run --rm cockroach-init` and after a while the container will exit and a new database called `startrek` with 2 tables called `episodes` and `quotes` will be from the `databases` tab in the cockroach administration interface.

```sql
SELECT
	episodes.title,
	quotes.characters,
	quotes.quote
FROM
	quotes 
JOIN
	episodes
ON
	episodes.id = quotes.episode
WHERE 
	quotes.characters LIKE '%Spock%'

```

Finally we're going to run the above query against these tables joining them together and returning all the quotes that involve Spock and the title of the episode the quote came from.
Running `docker-compose run --rm cockroach-select` should return 55 rows that consists of 3 columns named `title`, `character` and `quote`.

When looking in Jaeger on `localhost:16686` you should filter on the `sql txn` operation. The trace you're looking for will probably have at least 20 spans but they will vary depending on the distribution of the data between the nodes. While reading the [Cockroach's Architecture article](https://www.cockroachlabs.com/docs/stable/architecture/overview.html) you should try and look at the spans if you can recognize any of the operation described there.

To tear everything down again simply run `docker-compose down`.