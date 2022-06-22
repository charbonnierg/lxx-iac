- Convert docker command into ansible role:

```bash
docker service create \
    -p 8000:80 \
    --name app \
    --network traefik-network \
    --env GNT_MONGODB_HOST=mongo \
    --env GNT_MONGODB_DATABASE=gnt \
    --label "traefik.enable"="true" \
    --label "traefik.http.routers.app.entrypoints"="http,https" \
    --label "traefik.http.routers.app.rule"="Host(\`app.lxx.quest\`)" \
    --label "traefik.http.routers.app.service"="app" \
    --label "traefik.http.routers.app.tls"="true" \
    --label "traefik.http.routers.app.tls.certresolver"="letsencrypt" \
    --label "traefik.http.routers.app.tls.domains[0].main"="lxx.quest" \
    --label "traefik.http.routers.app.tls.domains[0].sans"="app.lxx.quest" \
    --label "traefik.http.services.app.loadbalancer.server.port"="80" \
    lxx
```