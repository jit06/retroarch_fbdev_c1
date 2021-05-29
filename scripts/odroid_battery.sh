#/bin/bash

BATTERY_STATE="Discharging"
BATTERY_LEVEL=50
LOW_LEVEL=730
MAX_LEVEL=1022
WARN_LOW=765
SCALE_DIV=$(($MAX_LEVEL-$LOW_LEVEL))
LAST_LED_STATE=0
WARNING_GPIO=75
GPIO=/sys/class/gpio
ACCESS=$GPIO/gpio$WARNING_GPIO

# wait for kernel module to be initialised
echo "odroid-battery : waiting for kernel module to be ready"
while [ ! -f /sys/class/power_supply/test_battery/capacity ] ;
do
 sleep 1
done;

if [ ! -d $ACCESS ] ; then
	echo $WARNING_GPIO > $GPIO/export
	echo out > $ACCESS/direction
	echo 0 > $ACCESS/value
fi


echo "odroid-battery : module ready. Start monitoring ADC0..."

while true ;
do
    #ADCVAL=$(cat /sys/class/saradc/saradc_ch0)
    ADCVAL=760

    # guess battery state with to "high to be true" adc value
    if [ $ADCVAL -gt $MAX_LEVEL ]; then
		 BATTERY_STATE="charging"
	else
	     BATTERY_STATE="discharging" 
    fi

    # toggle WARNING_GPIO pin if battery level is low
    if [ $ADCVAL -lt $WARN_LOW ]; then
		 if [ $LAST_LED_STATE -eq 0 ] ; then
		    LAST_LED_STATE=1
		    echo 1 > $ACCESS/value
		    echo "low level led ON"
		 else
		    LAST_LED_STATE=0
		    echo 0 > $ACCESS/value
		    echo "low level led OFF"
		 fi
    fi
    
    let "BATTERY_LEVEL=( 100*($ADCVAL - $LOW_LEVEL) / ($SCALE_DIV))"

    # write info to kernel parameters
    echo $BATTERY_LEVEL > /sys/module/test_power/parameters/battery_capacity
    echo $BATTERY_STATE > /sys/module/test_power/parameters/battery_status
    
    sleep 2
done;
