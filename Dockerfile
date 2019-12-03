FROM ronualdo/phoenix-api:v1.4.8 as devenv

RUN apk add inotify-tools

RUN mkdir -p /apps
COPY ./apps/ /apps/

WORKDIR /apps/peste_api
RUN mix deps.get &&\
  MIX_ENV=prod mix release --overwrite

# Production Image
FROM alpine:3.9

EXPOSE 4000/tcp

RUN apk add --update openssl bash libstdc++

WORKDIR /app/peste

COPY --from=devenv /apps/peste_api/_build/prod/rel/peste_api/ /app/peste/

CMD /app/peste/bin/peste_api start
