echo $1
case "$1" in
    "tx")
	case "$2" in
	    "cmd")
		case $3 in
		    "11")
			iwpriv wlan0 tx 0
			iwpriv wlan0 set_channel $4
			iwpriv wlan0 ena_chain 2
			iwpriv wlan0 pwr_cntl_mode 1
			iwpriv wlan0 set_txpower 15
			iwpriv wlan0 set_txrate 11B_LONG_11_MBPS
			iwpriv wlan0 tx 1 		

			;;
		    "54")
			iwpriv wlan0 tx 0
			iwpriv wlan0 set_channel $4
			iwpriv wlan0 ena_chain 2
			iwpriv wlan0 pwr_cntl_mode 1
			iwpriv wlan0 set_txpower 13
			iwpriv wlan0 set_txrate 11A_54_MBPS
			iwpriv wlan0 tx 1
			;;
		esac
	    	;;
	    "stop")
		iwpriv wlan0 tx 0
		iwpriv wlan0 rx 0
		;;
	esac	
        ;;
    "rx")
	case "$2" in
	    "cmd")
		iwpriv wlan0 tx 0
		iwpriv wlan0 rx 0
		iwpriv wlan0 set_channel $3
		iwpriv wlan0 ena_chain 1
		iwpriv wlan0 clr_rxpktcnt 1
		iwpriv wlan0 rx 1
		;;
	    "report")
		iwpriv wlan0 get_rxpktcnt
		;;
	esac
	;;
    "power")
	rmmod wlan
	insmod /system/lib/modules/wlan.ko con_mode=5
	ptt_socket_app &
	echo "$!" >/data/misc/wifi/pid.ptt
	iwpriv wlan0 ftm 1

	;;
    "shutdown")
	iwpriv wlan0 ftm 0
	rmmod wlan
	;;
	"bttest")
	hcitool cmd 0x06 0x0003
	hcitool cmd 0x03 0x0005 0x02 0x00 0x02
	hcitool cmd 0x03 0x001a 0x03
	hcitool cmd 0x03 0x0020 0x00
	hcitool cmd 0x03 0x0022 0x00
	;;
esac

exit 0
