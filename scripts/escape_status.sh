DEVICE="/dev/input/by-path/pci-0000:00:14.0-usb-0:2.2:1.0-event-kbd"
STATE=0

# Print the initial unlocked state when Waybar starts
echo '{"text": "", "class": "unlocked"}'

evtest "$DEVICE" 2>/dev/null | while read -r line; do
    # Only trigger when the key is pressed down (value 1)
    if echo "$line" | grep -q "KEY_CAPSLOCK.*value 1"; then
        if [ $STATE -eq 0 ]; then
            STATE=1
            echo '{"text": "", "class": "locked"}'
        else
            STATE=0
            echo '{"text": "", "class": "unlocked"}'
        fi
    fi
done
