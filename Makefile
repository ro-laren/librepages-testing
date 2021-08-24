default:
	agate --content dist/content/ \
       --certs ./certs/ \
       --addr [::]:1965 \
       --addr 0.0.0.0:1965 \
       --hostname localhost \
       --lang en-US

clean: 
	./scripts/build.sh clean

prod: clean
	./scripts/build.sh build
