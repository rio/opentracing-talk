## @fa[terminal]

# Rio Kierkels

---

## Ambassadors

---

## cube

![Video](https://player.vimeo.com/video/87002913)

---

## OpenTracing

```go
func Work(ctx context.Context, words []string) {
    span, ctx := opentracing.StartSpanFromContext(ctx, "work")
    defer span.Finish()

    span.SetTag("words", len(words))

    for i, word := range words {
        fmt.Println("iteration:", i, "word:", word)
    }
}
```