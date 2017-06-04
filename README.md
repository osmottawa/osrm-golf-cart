# OSRM Golf Cart Routing v2

## Workflow

### Install

- Docker
- OSMCTools

### Download OSM PBF

```
$ wget http://download.geofabrik.de/north-america/us/florida-latest.osm.pbf
```

### Clip OSM PBF

[How to install](https://wiki.openstreetmap.org/wiki/Osmconvert)

```
$ apt-get install osmctools
$ osmconvert florida-latest.osm.pbf -B=TheVillages.poly --out-pbf > TheVillages.osm.pbf
```

### Install OSRM

```
$ docker pull osrm/osrm-backend
$ git clone https://github.com/osmottawa/osrm-frontend && \
  cd osrm-frontend && \
  docker build -t osrm/osrm-frontend .
```

### Build OSRM Backend

```
$ docker run --rm -it \
  -v $(pwd)/profiles/golfcart.lua:/opt/golfcart.lua \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-extract -p /opt/golfcart.lua /data/TheVillages.osm.pbf

$ docker run --rm -it \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-contract /data/TheVillages.osrm

$ docker run -d \
  --name osrm-backend \
  -p 5000:5000 \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-routed /data/TheVillages.osrm
```

### Start OSRM Frontend

```
$ docker run -d --name osrm-frontend -p 9966:9966 \
  -e CENTER="28.915621,-81.982212" \
  -e BACKEND="https://golfcart.v1.addxy.com" \
  osrm/osrm-frontend
```

### References

- https://github.com/Project-OSRM/osrm-backend
- https://docs.docker.com/engine/installation/linux/ubuntu/
