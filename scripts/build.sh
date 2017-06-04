DATA="TheVillages"

docker run --rm -it \
  -v $(pwd)/profiles/golfcart.lua:/opt/golfcart.lua \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-extract -p /opt/golfcart.lua /data/$DATA.osm.pbf

docker run --rm -it \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-contract /data/$DATA.osrm

docker stop osrm-backend
docker rm osrm-backend
docker run -d \
  --name osrm-backend \
  -p 5000:5000 \
  -v $(pwd)/data:/data \
  osrm/osrm-backend \
  osrm-routed /data/$DATA.osrm