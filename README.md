## Ractor

Play with Ractor(Ruby actor)

## Usage

build image

```
$ docker build . -t ractor
```

and run like this

```
$ docker run --rm -v $(pwd):/usr/src -it ractor bash
```

```
$ docker run --rm -v $(pwd):/usr/src -it ractor ruby lib/ractor.rb
```

```
$ docker run --rm -v $(pwd):/usr/src -p 8080:8080 -it ractor ruby lib/webserver.rb
```

## References

https://hub.docker.com/r/wakaba260/ruby-ractor-dev
