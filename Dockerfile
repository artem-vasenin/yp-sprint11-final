FROM golang:1.22 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o tracker .

FROM debian:bookworm-slim

WORKDIR /app

COPY --from=builder /app/tracker .
COPY --from=builder /app/tracker.db .

CMD ["./tracker"]