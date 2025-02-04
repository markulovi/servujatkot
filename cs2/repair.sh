mkdir -p data
docker compose down
STEAMAPPVALIDATE=1 docker compose up -d cs2
