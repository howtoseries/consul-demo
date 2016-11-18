consul agent -bind=172.18.233.1 -client=0.0.0.0 -retry-join=172.18.233.20 -data-dir /tmp/data -ui -recursor=127.0.1.1
sudo echo Give the password for sudo, I\'ll configure the nat
sudo iptables -t nat -I PREROUTING -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -I PREROUTING -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -I OUTPUT -d localhost -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -I OUTPUT -d localhost -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
echo Use localhost in resolv.conf for DNS through Consul agent
