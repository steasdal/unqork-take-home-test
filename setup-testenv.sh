#!/bin/bash

docker build -f docker/Dockerfile -t testenv docker
docker run --rm --name testenv -v $PWD:/workdir -w /workdir -it testenv bash
