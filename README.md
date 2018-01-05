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
```
Clip from Poly
```
$ osmupdate "florida-latest.osm.pbf" "TheVillages.osm.pbf" -B="TheVillages.poly" -v --keep-tempfiles
```
**OR**
```
$ osmconvert florida-latest.osm.pbf -B=TheVillages.poly --out-pbf > TheVillages.osm.pbf
```

### Install OSRM

```
$ sudo docker pull osrm/osrm-backend
$ git clone https://github.com/osmottawa/osrm-frontend && \
  cd osrm-frontend && \
  docker build -t osrm/osrm-frontend .
```

### Build OSRM Backend

```
$ sudo docker run --rm -it \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-extract -p /opt/bicycle.lua /data/florida-latest.osm.pbf

$ sudo docker run --rm -it \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-contract /data/florida-latest.osrm

$ sudo docker run -d \
  --name osrm-backend \
  -p 5000:5000 \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-routed /data/florida-latest.osrm
```

### Start OSRM Frontend

```
$ sudo docker run -d --name osrm-frontend -p 9966:9966 \
  -e OSRM_CENTER="28.915621,-81.982212" \
  -e OSRM_BACKEND="https://api.villagesgps.com:8080" \
  osrm/osrm-frontend
```

### References

- https://github.com/Project-OSRM/osrm-backend
- https://docs.docker.com/engine/installation/linux/ubuntu/
