wget http://download.geofabrik.de/north-america/us/florida-latest.osm.pbf -O data/florida-latest.osm.pbf
osmupdate "data/florida-latest.osm.pbf" "data/TheVillages.osm.pbf" -B="data/TheVillages.poly" -v --keep-tempfiles
