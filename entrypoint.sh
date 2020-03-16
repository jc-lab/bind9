#!/bin/sh

if [ "x$RNDC_BIND_ADDRESS" == "x" ]; then
	RNDC_BIND_ADDRESS="localhost"
fi

if [ "x$RNDC_ALGORITHM$RNDC_SECRET" != "x" ]; then
	echo 'key "rndc-key" {' > /etc/bind/rndc.key
	echo '     algorithm '$RNDC_ALGORITHM';' >> /etc/bind/rndc.key
	echo '     secret "'$RNDC_SECRET'";' >> /etc/bind/rndc.key
	echo '};' >> /etc/bind/rndc.key
	
	echo 'include "/etc/bind/rndc.key";' > /etc/bind/rndc.conf
	echo 'options { default-server '$RNDC_BIND_ADDRESS'; default-key "rndc-key"; };' >> /etc/bind/rndc.conf
fi

[ ! -d /etc/bind/zones/ ] && mkdir -p /etc/bind/zones/

for name in $(ls /etc/bind/zones/*.conf); do
	echo "include \"$name\";" >> /etc/bind/named.conf
done

/usr/sbin/named -c /etc/bind/named.conf -g -u named

