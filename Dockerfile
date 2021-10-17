FROM golang:1.17 as build

WORKDIR /go/src/efk-demo

COPY . .

RUN go build -o app .

##############################

FROM scratch

WORKDIR /usr/local/fluent-demo

COPY --from=build /go/src/efk-demo/app .

CMD [ "./app" ]