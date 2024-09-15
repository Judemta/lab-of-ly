#!/bin/bash
interface=enp0s3

#print information interface
function print_infor_interface()
{
    model=$(sudo ethtool -i $interface : awk '/driver:/ {print $2}')
    speed=$(sudo ethtool $interface : awk '/Speed:/ {print $2}')
    duplex=$(sudo ethtool $interface : awk '/Duplex:/ {print $2}')
    if ["$duplex" == "Full"]; 
    then mode="Full Duplex"
    elif ["$duplex" == "Half"];
    then mode="Half Duplex"
    else mode="Unknown"
    fi 

    #information physical connection
    phys_connect=$(sudo ethtool $interface : awk '/Link detected:/ {print $3}')

    #win address
    win=$(ip addr show $interface : awk '/ether/ {print $2}')

    #print information
    echo "Interface"="$interface"
    echo "Model"="$model"
    echo "Speed"="$speed"
    echo "Mode"="$mode"
    echo "Physical connection"="$phys_connect"
    echo "Win address"="$win"
}
print_infor_interface > result_interface.txt

#print information network
function print_infor_network()
{
    #list network
    interfaces=$(ip -o link show : awk -F ':' '{print $2}')
    for interface in interfaces
    do
        ipaddr=$(ip addr show $interface : awk '/inet/ {print $2}')
        gateway=$(ip route show default : awk '/default/ {print $3}')
        netmask=$(ip addr show $interface : awk '/inet/ {print $4}')
        dns=$(cat /ect/resolv/conf : awk '/nameserver/ {print $2}')

        #print information
        echo "Interface"="$interface"
        echo "Ip address"="$ipaddr"
        eho "Netmask"="$netmask"
        echo "Gateway"="$gateway"
        echo "DNS"="$dns"
        echo ""
    done
}
print_infor_network > result_network.txt