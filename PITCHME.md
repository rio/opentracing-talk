## @fa[terminal]

# Rio Kierkels

---

## Ambassadors

---

## cube

![Video](https://vimeo.com/87002913)

---

## OpenTracing

```go
func startWork(ctx context.Context, words []string) {
    span, ctx := opentracing.StartSpanFromContext(ctx, "work")
    defer span.Finish()

    for i, word := range words {
        fmt.Println("iteration:", i, "word:", word)
    }
}
```