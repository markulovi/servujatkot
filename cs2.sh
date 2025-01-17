#!/bin/bash

cd cs2
./setup.sh
cd ..
docker compose restart cs2-server
