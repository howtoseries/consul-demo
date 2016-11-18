killall consul
sudo echo Give the password for sudo, I\'ll unconfigure consul nat
sudo iptables -t nat -D PREROUTING -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -D PREROUTING -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -D OUTPUT -d localhost -p udp -m udp --dport 53 -j REDIRECT --to-ports 8600
sudo iptables -t nat -D OUTPUT -d localhost -p tcp -m tcp --dport 53 -j REDIRECT --to-ports 8600
echo Remove localhost in resolv.conf to disable DNS through Consul agent
