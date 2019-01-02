# linshare-editor-onlyoffice

A backend application acts as a middleware between OnlyOffice document server and LinShare

## Initial setup steps

### Install dependencies
```
npm install
```

### Save public key to Linshare
```
LINSHARE_USER=root@localhost.localdomain LINSHARE_PASS=adminlinshare LINSHARE_HOST=http://localhost:30000 bash ./config/config_key.sh
```
> LINSHARE_USER and LINSHARE_PASS are Linshare administrator's username and password.

## Development

### Create a customized config file for development
```
cp ./config/default.json ./config/development.json
```

Some of notable configurations are:

- **linshare.baseUrl**: base url to LinShare api.
- **db.conectionString**: connection string to a MongoDB sever.


### Start server
```
npm start
```

### Run in development mode
```
npm run dev
```

### Run your unit tests
```
npm run test
```

## Configurations
### Enable authorization by JWT token for requests coming from OnlyOffice document server.

From Document server side, change the server configuration of `services.CoAuthoring.token.enable.request.outbox` to `true` and define the JWT secret key in `services.CoAuthoring.secret.outbox.string`.

From `linshare-editor-onlyoffice-backend` side, use the following configuration, note that both services must share a same `secret`
```
{
  "documentServer": {
      "signature": {
        "request": {
          "incoming": {
            "enable": "true",
            "algorithm": "HS256",
            "secret": "secret",
            "authorizationHeader": "authorization",
            "authorizationHeaderPrefix": "Bearer "
          }
        }
      }
    }
  }
}
```

## Docker

### Build
In order to utilize environment values for custom configuration. You can add your own environment values that will be used for certain configuration in `config/custom-environment-variables.json`, this configuration will override the other configuration files to use the environment values instead. To build the image:

```
docker build -t linagora/linshare-editor-onlyoffice-backend .
```

### Run
```
docker run -it -p 8800:8081 --rm --name linshare-editor-onlyoffice-backend \
  -e LINSHARE_BASE_URL=http://172.17.0.1:28080/linshare/webservice/rest \
  -e MONGO_CONNECTION_STRING=mongodb://localhost:27017/linshare-oo-editor \
  linagora/linshare-editor-onlyoffice-backend
```
