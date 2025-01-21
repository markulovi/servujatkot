# Laniservut

## Prerequisites

- Docker Compose

## Installation

Create `.env` files

```
./setup-env.sh
```

If running on Windows, copy `env/example/common.env.example` to `.env` in project root and other files to `env/*` while also removing the `.example`.

Fill in Get5 admins and Steam API key in `.env`. Other configs are mostly interpolated with these variables, change them if needed.

Optionally check if MetaMod, CounterStrikeSharp or MatchZy have been updated and create a pull request for the new versions.

Start CS2 server once to download files:

```
docker compose up -d cs2
```

Monitor logs for CS2 installation progress

```
docker compose logs -f cs2
```

When completed, stop server(s)

```
docker compose down
```

Run CS2 setup script

```
docker compose -f install-cs2-plugins-docker-compose.yml up
```

After successful execution, servers should be ready for use.

## Usage

```
docker compose up -d
```

Usage is also possible with a convenience script `./up.sh`

## Running another CS2 server

Copy files from primary server

```
./init-secondary-cs2.sh
```

Start secondary server

```
./start-secondary-cs2.sh
```

Server uses the same configs, but ports are 27016 for the game and 27021 for CSTV respectively.

TODO: Investigate Caddy reverse proxy usage to set hostnames for CS2 servers

## CS2 RCON

Substitute hostname, RCON password and optionally port with correct values for environment

```
docker run -it --rm outdead/rcon ./rcon -a $SERVER_HOSTNAME:27015 -p $CS2_RCONPW "mp_friendlyfire 1"
```

## TeamSpeak

Check teamspeak container logs for ServerAdmin privilege key

```
docker compose logs teamspeak
```

TeamSpeak should ask for the privilege key when the first user connects, and that user will become the server admin.

Configuration can then be done from the TeamSpeak client (e.g. right click server name -> Edit virtual server, Create channel etc.)

## Pro Pilkki 2

http://propilkki.net/index.php/pro-pilkki-2/verkkopelien-komennot

Configuration is applied at Docker image build time.

Edit `propilkki/pp2host.conf` and `propilkki/autohost.ini` and force rebuild

```
docker compose up -d --build propilkki2
```

By default only `$ORGA` and `$ADMIN` variables are passed to the build process.

## Admin panels

Pilkki admin should be accessible at `https://pilkki.<your hostname>`

Get5 admin should be accessible at `https://g5.<your hostname>`

**NOTE**: DNS needs to be configured for these urls to work. Point your hostname to the host ip. You can also use the ip to access admin panels.

## Troubleshooting

### CS2 error: Client is out of date

Set `STEAMAPPVALIDATE=1` in `env/cs2.env`

(Re)start CS2 server

```
docker compose restart cs2
```

Monitor logs for CS2 validation progress

```
docker compose logs -f cs2
```

When completed, stop server(s)

```
docker compose down cs2
```

Rerun CS2 setup script (`gameinfo.si` gets overwritten by validation)

```
./cs2.sh
```

Set `STEAMAPPVALIDATE=0` in `env/cs2.env`

Run server normally ([Usage](#usage))
