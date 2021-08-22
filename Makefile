default:
	agate --content content/ \
       --certs ./certs/ \
       --addr [::]:1965 \
       --addr 0.0.0.0:1965 \
       --hostname localhost \
       --lang en-US
