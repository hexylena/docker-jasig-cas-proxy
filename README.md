# Docker CAS AUTH Proxy

Running the demo

```
docker-compose up
```

## Connecting to a Service on Localhost

This command assumes that the service you wish to proxy to is running on port `10000` and that you wish the proxy to listen on `localhost:8000`

```console
docker run -it -p8000:8000 -e BACKEND_PORT=10000 -e BACKEND_NAME=localhost -e LISTEN_PORT=8000 -e LISTEN_PORT_SSL=8443 -e SERVER_NAME=localhost --net host quay.io/erasche/jasig-cas-proxy:latest
```

## Environment Variables

Variable           | Default     | Meaning
------------------ | ----------- | ------------------
`BACKEND_PORT`     | 8000        | Port to contact on `target`, i.e. the container which has been linked to this one
`BACKEND_NAME`     | target      | Name of the backend to connect to. Defaults to target (for a container linked in a `container-name:target`). Can change to e.g. localhost for running with `--net host`
`SERVER_NAME`      | localhost   | A domain name which resolves to this container. `localhost` should be fine.
`DOMAIN`           | example.edu | The domain name appended to the `REMOTE_USER` header before it is passed on to the backend service.
`LISTEN_PORT`      | 80          | Port to listen on. Once the request hits the apache2 proxy, it looks at its own ServerName and listen port in order to construct the redirect to the CAS server. This has to be right or you'll be redirected to `http://SERVER_NAME/` (which may indeed be correct)
`CAS_LOGIN_URL`    | ...         | URL to use as a login site. Defaults to a custom CAS server which will return the user `test` for any query.
`CAS_VALIDATE_URL` | ...         | URL for validation. Validates any ticket request and returns the `test` user.

## LICENSE

AGPLv3
