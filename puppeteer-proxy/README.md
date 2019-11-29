# puppeteer-docker-proxy

Uses express node.js library to listen for incoming requests on default port 3000 and returns whole document provided in uri query parameter as response. (The document is returned with the use of puppeteer node.js library and using document.documentElement.outerHTML property).

## Usage

```
docker build -t puppeteer-docker-proxy . && docker run -it -p 3000:3000 puppeteer-docker-proxy
```

http://localhost:3000/?uri=https://www.google.com

The uri must be well-formed like. https://www.google.com

