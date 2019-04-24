# Learn

## Warm up

1. Install Engine
1. Change to Linux core

1. Start a nginx server, mount a host folder or copy host files into container

``` cmd
docker run -d -p 8080:80 nginx:latest  
docker run -d -p 8080:80 -v c:\...\*:/usr/share/nginx/html nginx:latest  
docker cp .\*  nginx:/usr/share/nginx/html

1. Commit to create a new image
