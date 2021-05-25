#/bin/bash

BATTERY_STATE="Discharging"
BATTERY_LEVEL=50

# wait for kernel module to be initialised
echo "odroid-battery : waiting for kernel module to be ready"
while [ ! -f /sys/class/power_supply/test_battery/capacity ] ;
do
 sleep 1
done;

echo "odroid-battery : module ready. Start monitoring ADC0..."

while true ;
do
    ADCVAL=$(cat /sys/class/saradc/saradc_ch0)
    
    # guess battery state with to "high to be true" adc value
    if [ $ADCVAL -gt 1020 ]; then
		 BATTERY_STATE="charging"
	else
	     BATTERY_STATE="discharging" 
    fi
    
    # calculate battery level, guessing that full battery is 1000, not 1024
    let "BATTERY_LEVEL=$ADCVAL/10"
    
    
    # write info to kernel parameters
    echo $BATTERY_LEVEL > /sys/module/test_power/parameters/battery_capacity
    echo $BATTERY_STATE > /sys/module/test_power/parameters/battery_status
    
    sleep 2
done;
