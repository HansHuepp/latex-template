iptables -t raw -I PREROUTING -p esp -j LOG
iptables -t raw -I PREROUTING -p ah -j LOG
iptables -t raw -I PREROUTING -p udp -m multiport --dports 500,4500 -j LOG

iptables -t raw -I OUTPUT -p esp -j LOG
iptables -t raw -I OUTPUT -p ah -j LOG
iptables -t raw -I OUTPUT -p udp -m multiport --dports 500,4500 -j LOG

iptables -t mangle -I PREROUTING -m policy --pol ipsec --dir in -j LOG
iptables -t mangle -I POSTROUTING -m policy --pol ipsec --dir out -j LOG

iptables -t filter -I INPUT -m addrtype --dst-type LOCAL -m policy --pol ipsec --dir in -j LOG

iptables -t filter -I FORWARD -m addrtype ! --dst-type LOCAL -m policy --pol ipsec --dir in -j LOG

iptables -t filter -I OUTPUT -m policy --pol ipsec --dir out -j LOG