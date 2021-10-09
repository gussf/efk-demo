FROM golang:1.17 as build

WORKDIR /go/src/fluentd-demo

COPY . .

RUN go build -o app .

##############################

FROM scratch

WORKDIR /usr/local/fluent-demo

COPY --from=build /go/src/fluentd-demo/app .

CMD [ "./app" ]