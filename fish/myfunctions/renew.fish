
function renew -d "renew dhcp lease from the command line"
    if type -q ipconfig
        sudo ipconfig set en0 DHCP
    else
        echo "ipconfig required"
    end
end