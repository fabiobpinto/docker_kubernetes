FROM alpine

COPY hello.sh /hello.sh

CMD ["/hello.sh", "Hello, World by CMD!"]