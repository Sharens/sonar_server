# Backend Dockerfile
FROM golang:1.20-alpine
WORKDIR /app

# Kopiowanie modułu i kodu
COPY go.mod main.go .
# Pobranie zależności i budowanie aplikacji
RUN go mod tidy && \
    go build -o server .

EXPOSE 8080
CMD ["./server"]
