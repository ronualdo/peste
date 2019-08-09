FROM ronualdo/phoenix-api:v1.4.8 as devenv

RUN mkdir -p /app/peste_api
COPY ./peste_api /app/peste_api
WORKDIR /app/peste_api

RUN mix deps.get &&\
  MIX_ENV=prod mix release --overwrite

# Production Image
FROM alpine:3.9

EXPOSE 4000/tcp

RUN apk add --update openssl bash

WORKDIR /app/peste_api
  COPY --from=devenv /app/peste_api/_build/prod/rel/peste_api/ /app/peste_api/

CMD /app/peste_api/bin/peste_api start
