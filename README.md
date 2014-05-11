# docker-fusioninvoice-nginx

A Dockerfile that installs the latest wordpress, nginx, php-apc and php-fpm.

NB: A big thanks to [eugeneware](https://github.com/eugeneware/docker-wordpress-nginx) for the template of this Dockerfile!

## Installation

```
$ git clone https://github.com/onny/docker-fusioninvoice-nginx.git
$ cd docker-fusioninvoice-nginx
$ sudo docker build -t="docker-fusioninvoice-nginx" .
```

## Usage

To spawn a new instance of FusionInvoice:

```bash
$ sudo docker run -p 80:80 -d docker-fusioninvoice-nginx
```
You can the visit the following URL in a browser on your host machine to get started:

```
http://127.0.0.1:<port>
```
