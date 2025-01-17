# Laniservut

## Installation

```
cp .env.example .env
```

Fill in the values.

Latest metamod download url can be found from https://www.metamodsource.net/downloads.php?branch=dev

Latest cssharp download url can be found from https://github.com/roflmuffin/CounterStrikeSharp/releases (the one with runtime)

Latest matchzy download url can be found from https://github.com/shobhit-pathak/MatchZy/releases/ (the one without cssharp)

```
export $(grep -v '^#' .env | xargs)
```

```
mkdir -p cs2/steam
mkdir mumble
```

```
docker network create -d bridge caddy
docker compose up -d
```

## CS2 installation

Install metamod, cssharp and matchzy

```
cd cs2
./setup.sh
cd ..
docker compose restart cs2-server
```

## CS2 rcon

docker run -it --rm outdead/rcon ./rcon -a cs2.poggers.fi:27015 -p servujatkot "<komento>"

## TeamSpeak

Check teamspeak container logs for ServerAdmin privilege key

## Pro Pilkki 2

http://propilkki.net/index.php/pro-pilkki-2/verkkopelien-komennot
