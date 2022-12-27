function current_networkservice() {
    network=''
    if [ "$(networksetup -getnetworkserviceenabled Ethernet)" = 'Enabled' ]; then
       network='Ethernet'
    elif [ "$(networksetup -getnetworkserviceenabled Wi-Fi)" = 'Enabled' ]; then
       network='Wi-Fi'
    else
       network=''
    fi
    echo $network
}

function proxy() {
    network=`current_networkservice`
    if [ -z network ]; then
        echo "Unrecognized network"
        return 1
    fi

    case "$1" in
    on)
        networksetup -setwebproxystate $network on;
        networksetup -setsecurewebproxystate $network on;
        networksetup -setwebproxy $network 127.0.0.1 8888;
        networksetup -setsecurewebproxy $network 127.0.0.1 8888;
        networksetup -setautoproxystate $network off;
        networksetup -setsocksfirewallproxystate $network off;
        ;;
    g)
        networksetup -setwebproxystate $network off;
        networksetup -setsecurewebproxystate  $network off;
        networksetup -setautoproxystate $network off;
        networksetup -setsocksfirewallproxy "$network" localhost 14179
        ;;
    off)
        networksetup -setwebproxystate $network off;
        networksetup -setsecurewebproxystate  $network off;
        networksetup -setautoproxystate $network off;
        networksetup -setsocksfirewallproxystate $network off;
        ;;
    s)
        socks_status=$(networksetup -getsocksfirewallproxy $network | head -n 3;)
        socks_enable=$(echo $socks_status | head -n 1 | awk '{print $2}')
        socks_ip=$(echo $socks_status | head -n 2 | tail -n 1 | awk '{print $2}')
        socks_port=$(echo $socks_status | tail -n 1 | awk '{print $2}')

        if [ "$socks_enable" = "Yes" ]; then
            echo -e "${green}Socks: ✔${NC}" $socks_ip ":" $socks_port
        else
            echo -e "${RED}Socks: ✘${NC}" $socks_ip ":" $socks_port
        fi

        http_status=$(networksetup -getwebproxy $network | head -n 3)
        http_enable=$(echo $http_status | head -n 1 | awk '{print $2}')
        http_ip=$(echo $http_status | head -n 2 | tail -n 1 | awk '{print $2}')
        http_port=$(echo $http_status | tail -n 1 | awk '{print $2}')

        if [ "$http_enable" = "Yes" ]; then
            echo -e "${green}HTTP : ✔${NC}" $http_ip ":" $http_port
        else
            echo -e "${RED}HTTP : ✘${NC}" $http_ip ":" $http_port
        fi

        https_status=$(networksetup -getsecurewebproxy $network | head -n 3)
        https_enable=$(echo $https_status | head -n 1 | awk '{print $2}')
        https_ip=$(echo $https_status | head -n 2 | tail -n 1 | awk '{print $2}')
        https_port=$(echo $https_status | tail -n 1 | awk '{print $2}')

        if [ "$https_enable" = "Yes" ]; then
            echo -e "${green}HTTPS: ✔${NC}" $https_ip ":" $https_port
        else
            echo -e "${RED}HTTPS: ✘${NC}" $https_ip ":" $https_port
        fi
        ;;
    *)
        echo "Usage: p {on|off|g|s}"
        echo "p on : Set proxy to Charles(port 8888)"
        echo "p off: Reset proxy to system default"
        echo "p g  : Set proxy to GoAgentx(port 14179)"
        echo "p s  : Show current network proxy status"
        echo "p *  : Show usage"
        ;;
    esac
}

proxy s