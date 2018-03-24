## Rio Kierkels

---?image=assets/ambassadors.png&size=auto 75%

Note:
Creative Production Studio
Mostly works on TV commercials doing everything from music and sound to visual effects and colour

---?image=assets/Cube_Logo_flat_white.png&size=auto 20%

Note:
work on cube
web platform that stores and processes master quality video for archiving and review purpouses
with the capability to eventually deliver to broadcasting stations

growth in the last couple of years evolving
from single threaded to multithreaded to micro and not so micro services.
One of the main problems is keeping up the levels of observability and visibility
into the system while it expands across process and network boundaries.

---?image=assets/grafana.png&size=100% auto

---?image=assets/opentracing-horizontal-white.svg&size=66% auto

---?image=assets/jaeger-horizontal-white.svg&size=66% auto

---

logging 

Note:
traditionally logging has been part of this domain tracking events as they occur like errors or an audit trail.
metrics is another one which deals with information that can be aggregated to answer questions like
what is the number of requests per second that we are handeling, what is the duration of those requests
and how many of those are considered errors.

---

scope

Note:
Tracing is about request scoped information. This single request, which systems did it hit? What was the duration of each unit of work that it triggered and what is the relationship between them. This is where the opentracing project comes in.

---?image=assets/opentracing-text-logo.png&size=75% auto

Note:
opentracing is part of the cloud native computing foundation alongside of projects like kubernetes and prometheus. 
But unlike those projects it is not a software package, rather it is a specification for an api with implementations in a number of different languages.

---?image=assets/trace_row1.png&size=60% auto

---?image=assets/trace_row2.0.png&size=60% auto

---?image=assets/trace_row2.1.png&size=60% auto

---?image=assets/trace.png&size=60% auto

---

Note:
a trace is a collection of spans each representing a unit of work with a name, start- and end-time.

together it turns the path of a request through different services from this into this.

---

```go
func Auth(ctx context.Context, userID uuid.UUID) (User, error) {





    user := GetUser(ctx, userID)
    if !user.IsAuthorized {




        return nil, errors.New("unauthorized")
    }



    return user, nil
}
```
---
```go
func Auth(ctx context.Context, userID uuid.UUID) (User, error) {
    span, ctx := opentracing.StartSpanFromContext(ctx, "Auth")
    defer span.Finish()

    span.SetTag("user.id", userID)

    user := GetUser(ctx, userID)
    if !user.IsAuthorized {
        span.LogField(
            log.String("event", "unauthorized"),
            log.Bool("error", true),
        )
        return nil, errors.New("unauthorized")
    }

    span.LogField(log.String("event", "authorized"))

    return user, nil
}
```
---
```go
func Auth(ctx context.Context, userID uuid.UUID) (User, error) {



    user := GetUser(ctx, userID)
    if !user.IsAuthorized {




        return nil, errors.New("unauthorized")
    }

    return user, nil
}
```
---
```go
func Auth(ctx context.Context, userID uuid.UUID) (User, error) {
    span, ctx := opentracing.StartSpanFromContext(ctx, "Auth")
    defer span.Finish()
    span.SetTag("user.id", userID)
    user := GetUser(ctx, userID)
    if !user.IsAuthorized {
        span.LogField(
            log.String("event", "unauthorized"),
            log.Bool("error", true),
        )
        return nil, errors.New("unauthorized")
    }
    span.LogField(log.String("event", "authorized"))
    return user, nil
}
```
---
```go
func Auth(ctx context.Context, userID uuid.UUID) (User, error) {
    span, ctx := opentracing.StartSpanFromContext(ctx, "Auth")
    defer span.Finish()

    span.SetTag("user.id", userID)

    user := GetUser(ctx, userID)
    if !user.IsAuthorized {
        span.LogField(
            log.String("event", "unauthorized"),
            log.Bool("error", true),
        )
        return nil, errors.New("unauthorized")
    }

    span.LogField(log.String("event", "authorized"))

    return user, nil
}
```
@[1,19]
@[7,8,13,14,18]
---

(go code example)
(python code example)

[tags]
[logs]
[bagage]

But all of this instrumentation doesn't actually do anything without a tracer backing it. This is where the vendor agnostic part comes into play.
The actual work of collecting, storeing and processing those traces is being done by a backend. Which backend doesn't matter as long as that backend implements the opentracing api.

[enumerate tracers]

[demo]

[how to start]