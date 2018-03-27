## Intro to OpenTracing

Note:
problem space

---

## Rio Kierkels

---?image=assets/ambassadors.png&size=auto 75%

@title[Ambassadors]

Note:
Creative Production Studio
Mostly works on TV commercials doing everything from music and sound to visual effects and colour

---?image=assets/Cube_Logo_flat_white.png&size=auto 20%

@title[cube]

Note:
work on cube
web platform that stores and processes master quality video for archiving and review purpouses
with the capability to eventually deliver to broadcasting stations

---?video=http://localhost:8000/CUBE_2014.mp4

Note:
growth in the last couple of years evolving
from single threaded to multithreaded to micro and not so micro services.
One of the main problems is keeping up the levels of observability and visibility
into the system while it expands across process and network boundaries.

---?image=assets/logs.png&size=90% auto

@title[Logs]

Note:
traditionally logging has been part of this domain tracking events as they occur like errors or an audit trail.

---?image=assets/grafana.png&size=100% auto

@title[Metrics]

Note:
metrics is another one which deals with information that can be aggregated to answer questions like
what is the number of requests per second that we are handeling, what is the duration of those requests
and how many of those are considered errors.

---

@title[Request Scoped]

## Request Scoped

Note:
Tracing is about request scoped information. This single request, which systems did it hit? What was the duration of each unit of work that it triggered and what is the relationship between them. This is where the opentracing project comes in.

---?image=assets/opentracing-horizontal-white.svg&size=66% auto

@title[OpenTracing API]

Note:
opentracing is part of the cloud native computing foundation alongside of projects like kubernetes and prometheus. 
But unlike those projects it is not a software package, rather it is a specification for an api with implementations in a number of different languages.

---

@title[What is a Trace?]

## What is a Trace?

- Spans
- Operation Name |
- Start Time     |
- Finish Time    |
- Relationship   |

---?image=assets/trace_row1.png&size=60% auto

Note:
a trace is a collection of spans each representing a unit of work with a name, start- and end-time.
together it turns the path of a request through different services from this into this.

---?image=assets/trace_row2.0.png&size=60% auto

---?image=assets/trace_row2.1.png&size=60% auto

---?image=assets/trace.png&size=60% auto

---?image=assets/auth-1.png&size=66% auto

@title[Code Example]

---?image=assets/auth-2.png&size=66% auto

---?image=assets/auth-3.png&size=66% auto

---?image=assets/auth-4.png&size=66% auto

---?image=assets/auth-5.png&size=66% auto

---?image=assets/auth-6.png&size=66% auto

---?image=assets/auth-7.png&size=66% auto

@title[Span Tags]

Note:
tags

---?image=assets/auth-8.png&size=66% auto

@title[Span Logs]

Note:
logs

---

## Where do I begin?

- RPC Layer / Mesh Network
- Web Framework                 |
- Reverse Proxy                 |
- Queues / In Memory Datastores |
- Database ORM / Driver         |
- Logger                        |

Note:
- rpc: GRPC, thrift, akka, envoy
- web: Django, Spring Cloud
- reverse proxy: Nginx
- queues/in memory datastores: redis, rabbitqp
- ORM: SQLAlchemy

---?image=assets/jaeger-horizontal-white.svg&size=66% auto

@title[Jaeger]

Note:
But all of this instrumentation doesn't actually do anything without a tracer backing it. This is where the vendor agnostic part comes into play.
The actual work of collecting, storeing and processing those traces is being done by a backend. Which backend doesn't matter as long as that backend implements the opentracing api.

---

# [demo]