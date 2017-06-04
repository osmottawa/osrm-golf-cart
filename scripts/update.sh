wget http://download.geofabrik.de/north-america/us/florida-latest.osm.pbf -P data/
osmupdate "data/florida-latest.osm.pbf" "data/TheVillages.osm.pbf" -B="data/TheVillages.poly" -v --keep-tempfiles
