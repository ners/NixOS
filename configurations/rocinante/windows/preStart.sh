modprobe -i vfio_pci
mkdir -p /tmp/defaultDrivers
for dev in $DEVICES; do
	if [ -L /sys/bus/pci/drivers/vfio-pci/$dev ]; then
		echo $dev already bound to vfio-pci
		continue
	fi
	if [ -L /sys/bus/pci/devices/$dev/driver ]; then
		if ! [ -L /tmp/defaultDrivers/$dev ]; then
			ln -s $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver) /tmp/defaultDrivers/$dev
		fi
		echo Unbinding $dev from $(readlink --canonicalize /sys/bus/pci/devices/$dev/driver)
		echo $dev > /sys/bus/pci/devices/$dev/driver/unbind
	fi
	echo Binding $dev to vfio-pci
	echo vfio-pci > /sys/bus/pci/devices/$dev/driver_override
	echo $dev > /sys/bus/pci/drivers/vfio-pci/bind
done

# tunctl -t $TAP_INTERFACE -u $(whoami)
# brctl addif $BRIDGE_INTERFACE $TAP_INTERFACE
# ip link set up dev $TAP_INTERFACE
