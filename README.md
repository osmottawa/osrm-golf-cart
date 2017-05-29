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

```
$ apt-get install osmctools
$ osmconvert florida-latest.osm.pbf -B=TheVillages.poly --out-pbf > TheVillages.osm.pbf
```

### Build OSRM Backend

```
$ docker run -t -v $(pwd):/data osrm/osrm-backend osrm-extract -p /opt/bicycle.lua /data/TheVillages.osm.pbf
$ docker run -t -v $(pwd):/data osrm/osrm-backend osrm-contract /data/TheVillages.osrm
$ docker run -d --name osrm-backend -p 5000:5000 -v $(pwd):/data osrm/osrm-backend osrm-routed /data/TheVillages.osrm
```

### Start OSRM Frontend

```
$ docker run -d --name osrm-frontend -p 9966:9966 osrm/osrm-frontend
```

### References

- https://github.com/Project-OSRM/osrm-backend
- https://docs.docker.com/engine/installation/linux/ubuntu/
