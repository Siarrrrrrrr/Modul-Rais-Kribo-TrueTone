#!/system/bin/sh

while [ -z "$(getprop sys.boot_completed)" ]; do
   	sleep 1
done
check_write() {
   	if [ -f "$1" ]; then
        	if ! grep -q "$2" "$1"; then
            		echo "$2" >"$1"
        	fi
    	fi
	}
value=220
check_write "1" >/sys/devices/platform/kcal_ctrl.0/kcal_enable
check_write "0" >/sys/module/msm_drm/parameters/kcal_hue
kcal_1="/sys/devices/platform/kcal_ctrl.0"
kcal_2="$(find /sys/module/msm_drm/parameters/ -maxdepth 1 -type f -name 'kcal_*')"
if [ -d "$kcal_1" ]; then
	echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
	while true; do
    		brightness_group_rounded=$(settings get system screen_brightness)
		brightness_kontol=$(settings get system screen_brightness)
		if [ "$brightness_group_rounded" -ge 1 ] && [ "$brightness_group_rounded" -le 10 ]; then
        		target_red_value=255
			target_blue_value=$((256 - (11 - brightness_kontol) * 4))
			target_kcal_value=255
			target_kcal_cont=$((253 - (11 - brightness_kontol)))
			target_kcal_sat=$((254 - (11 - brightness_kontol)))
		elif [ "$brightness_group_rounded" -ge 11 ] && [ "$brightness_group_rounded" -le 46 ]; then
			target_red_value=255
			target_blue_value=255
			target_kcal_value=255
			target_kcal_cont=255
			target_kcal_sat=255
		elif [ "$brightness_group_rounded" -ge 47 ] && [ "$brightness_group_rounded" -le 255 ]; then
			target_red_value=$((256 - (brightness_kontol - 46)))
			target_blue_value=255
    target_kcal_value=255
			b=$((256 + (brightness_kontol - 46) / 20))
    target_kcal_cont=$(printf "%.0f" $b)
			c=$((257 + (brightness_kontol - 46) / 20))
    target_kcal_sat=$(printf "%.0f" $c)
	        fi
        	if [ "$target_red_value" -lt "$value" ]; then
            		target_red_value="$value"
       		fi
       		if [ "$target_blue_value" -lt "$value" ]; then
       			target_blue_value="$value"
       		fi	
        	if [ "$target_red_value" -gt 255 ]; then
            		target_red_value=255
       		fi
       		if [ "$target_blue_value" -gt 255 ]; then
       			target_blue_value=255
       		fi
       		current_kcal_value=$(cat /sys/devices/platform/kcal_ctrl.0/kcal_val)
       		current_kcal_cont=$(cat /sys/devices/platform/kcal_ctrl.0/kcal_cont)
       		current_kcal_sat=$(cat /sys/devices/platform/kcal_ctrl.0/kcal_sat)
        	current_red_value=$(cat /sys/devices/platform/kcal_ctrl.0/kcal | cut -d' ' -f1)
        	current_blue_value=$(cat /sys/devices/platform/kcal_ctrl.0/kcal | cut -d' ' -f3)
        	if [ "$current_kcal_value" -lt "$target_kcal_value" ]; then
            		current_kcal_value=$((current_kcal_value + 1))
        	elif [ "$current_kcal_value" -gt "$target_kcal_value" ]; then
            		current_kcal_value=$((current_kcal_value - 1))
        	fi
        	if [ "$current_kcal_cont" -lt "$target_kcal_cont" ]; then
            		current_kcal_cont=$((current_kcal_cont + 1))
        	elif [ "$current_kcal_cont" -gt "$target_kcal_cont" ]; then
            		current_kcal_cont=$((current_kcal_cont - 1))
        	fi
        	if [ "$current_kcal_sat" -lt "$target_kcal_sat" ]; then
            		current_kcal_sat=$((current_kcal_sat + 1))
        	elif [ "$current_kcal_sat" -gt "$target_kcal_sat" ]; then
            		current_kcal_sat=$((current_kcal_sat - 1))
        	fi
        	if [ "$current_red_value" -lt "$target_red_value" ]; then
            		current_red_value=$((current_red_value + 1))
        	elif [ "$current_red_value" -gt "$target_red_value" ]; then
            		current_red_value=$((current_red_value - 1))
        	fi
		if [ "$current_blue_value" -lt "$target_blue_value" ]; then
            		current_blue_value=$((current_blue_value + 1))
        	elif [ "$current_blue_value" -gt "$target_blue_value" ]; then
            		current_blue_value=$((current_blue_value - 1))
        	fi
        	echo "$current_red_value 255 $current_blue_value" > /sys/devices/platform/kcal_ctrl.0/kcal
        	echo "$current_kcal_value" > /sys/devices/platform/kcal_ctrl.0/kcal_val
        	echo "$current_kcal_cont" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
        	echo "$current_kcal_sat" > /sys/devices/platform/kcal_ctrl.0/kcal_sat
    		sleep 1
	done > /dev/null 2>&1 &
elif [ -n "$kcal_2" ]; then
    	echo "0" >/sys/module/msm_drm/parameters/kcal_hue
	while true; do
    		brightness_group_rounded=$(settings get system screen_brightness)
		brightness_kontol=$(settings get system screen_brightness)
                if [ "$brightness_group_rounded" -ge 1 ] && [ "$brightness_group_rounded" -le 10 ]; then
        		target_red_value=255
			target_blue_value=$((256 - (11 - brightness_kontol) * 4))
			target_kcal_value=255
			target_kcal_cont=$((253 - (11 - brightness_kontol)))
			target_kcal_sat=$((254 - (11 - brightness_kontol)))
		elif [ "$brightness_group_rounded" -ge 11 ] && [ "$brightness_group_rounded" -le 46 ]; then
			target_red_value=255
			target_blue_value=255
			target_kcal_value=255
			target_kcal_cont=255
			target_kcal_sat=255
		elif [ "$brightness_group_rounded" -ge 47 ] && [ "$brightness_group_rounded" -le 255 ]; then
			target_red_value=$((256 - (brightness_kontol - 46)))
			target_blue_value=255
    target_kcal_value=255
			b=$((256 + (brightness_kontol - 46) / 20))
    target_kcal_cont=$(printf "%.0f" $b)
			c=$((257 + (brightness_kontol - 46) / 20))
    target_kcal_sat=$(printf "%.0f" $c)
	        fi
        	if [ "$target_red_value" -lt "$value" ]; then
            		target_red_value="$value"
       		fi
       		if [ "$target_blue_value" -lt "$value" ]; then
       			target_blue_value="$value"
       		fi	
        	if [ "$target_red_value" -gt 255 ]; then
            		target_red_value=255
       		fi
       		if [ "$target_blue_value" -gt 255 ]; then
       			target_blue_value=255
       		fi
       		current_kcal_value=$(cat /sys/module/msm_drm/parameters/kcal_val)
       		current_kcal_cont=$(cat /sys/module/msm_drm/parameters/kcal_cont)
       		current_kcal_sat=$(cat /sys/module/msm_drm/parameters/kcal_sat)
	        current_red_value=$(cat /sys/module/msm_drm/parameters/kcal_red)
		current_blue_value=$(cat /sys/module/msm_drm/parameters/kcal_blue)
        	if [ "$current_kcal_value" -lt "$target_kcal_value" ]; then
            		current_kcal_value=$((current_kcal_value + 1))
        	elif [ "$current_kcal_value" -gt "$target_kcal_value" ]; then
            		current_kcal_value=$((current_kcal_value - 1))
        	fi
        	if [ "$current_kcal_cont" -lt "$target_kcal_cont" ]; then
            		current_kcal_cont=$((current_kcal_cont + 1))
        	elif [ "$current_kcal_cont" -gt "$target_kcal_cont" ]; then
            		current_kcal_cont=$((current_kcal_cont - 1))
        	fi
        	if [ "$current_kcal_sat" -lt "$target_kcal_sat" ]; then
            		current_kcal_sat=$((current_kcal_sat + 1))
        	elif [ "$current_kcal_sat" -gt "$target_kcal_sat" ]; then
            		current_kcal_sat=$((current_kcal_sat - 1))
        	fi
        	if [ "$current_red_value" -lt "$target_red_value" ]; then
            		current_red_value=$((current_red_value + 1))
        	elif [ "$current_red_value" -gt "$target_red_value" ]; then
            		current_red_value=$((current_red_value - 1))
        	fi
		if [ "$current_blue_value" -lt "$target_blue_value" ]; then
            		current_blue_value=$((current_blue_value + 1))
        	elif [ "$current_blue_value" -gt "$target_blue_value" ]; then
            		current_blue_value=$((current_blue_value - 1))
        	fi
        	echo "$current_kcal_value" > /sys/module/msm_drm/parameters/kcal_val
        	echo "$current_kcal_cont" > /sys/module/msm_drm/parameters/kcal_cont
        	echo "$current_kcal_sat" > /sys/module/msm_drm/parameters/kcal_sat
        	echo "$current_red_value" > /sys/module/msm_drm/parameters/kcal_red
		green_value=255
    		echo "$green_value" > /sys/module/msm_drm/parameters/kcal_green
    		echo "$current_blue_value" > /sys/module/msm_drm/parameters/kcal_blue
    	sleep 1
	done > /dev/null 2>&1 &
fi
boot_wait() {
  while [ -z "$(getprop sys.boot_completed)" ]; do
    sleep 1
  done
}
sf_saturation_boost() {
  service call SurfaceFlinger 1023 i32 0
  service call SurfaceFlinger 1022 f 1.5
}
boot_wait
sf_saturation_boost
