# Docker CAS AUTH Proxy

Running:

```
docker-compose up
```

## Environment Variables

Variable       | Default     | Meaning
-------------- | ----------- | ------------------
`BACKEND_PORT` | 8000        | Port to contact on `target`, i.e. the container which has been linked to this one
`SERVER_NAME`  | localhost   | A domain name which resolves to this container. `localhost` should be fine.
`DOMAIN`       | example.edu | The domain name appended to the `REMOTE_USER` header before it is passed on to the backend service.
`LISTEN_PORT`  | 80          | Port to listen on. Once the request hits the apache2 proxy, it looks at its own ServerName and listen port in order to construct the redirect to the CAS server. This has to be right or you'll be redirected to `http://SERVER_NAME/` (which may indeed be correct)

## LICENSE

AGPLv3
