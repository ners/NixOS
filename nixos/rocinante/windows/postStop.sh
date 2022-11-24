for dev in $DEVICES; do
	if ! [ -L /tmp/defaultDrivers/$dev ]; then continue; fi
	if [ -L /sys/bus/pci/devices/$dev/driver ]; then
		echo Unbinding $dev from $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver)
		echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
	fi
	if [ -L /tmp/defaultDrivers/$dev/bind ]; then
		echo Binding $dev to $(readlink --canonicalize /tmp/defaultDrivers/$dev)
		echo $dev > /tmp/defaultDrivers/$dev/bind
	fi
done

# brctl delif $BRIDGE_INTERFACE $TAP_INTERFACE
# tunctl -d $TAP_INTERFACE
