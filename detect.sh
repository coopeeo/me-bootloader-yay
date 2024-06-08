#!/bin/bash

# Clear existing GRUB configuration
cat /boot/grub/grub.reset.cfg > /boot/grub/grub.cfg

# Automatically detect installed operating systems and generate GRUB configuration entries
os-prober | while IFS= read -r line; do
    echo "Found operating system: $line"
    
    # Extract relevant information from the os-prober output
    entry=$(echo "$line" | cut -d ':' -f 2)
    uuid=$(echo "$line" | cut -d ':' -f 1)
    
    # Generate GRUB configuration entry
    echo "menuentry 'Auto-detected: $entry' {" >> /boot/grub/grub.cfg
    echo "    search --no-floppy --fs-uuid --set=root $uuid" >> /boot/grub/grub.cfg
    echo "    chainloader +1" >> /boot/grub/grub.cfg
    echo "}" >> /boot/grub/grub.cfg
    
done

# Add additional custom boot entries if needed
# echo "menuentry 'Custom Entry' {" >> /boot/grub/grub.cfg
# echo "    # Add boot options here" >> /boot/grub/grub.cfg
# echo "}" >> /boot/grub/grub.cfg
