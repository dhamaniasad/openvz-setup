#!/bin/bash

# Reboot System

echo $'The system must go down for reboot now. Press Y to reboot or N to end the execution of this script :'
	read key
	until [ "${key}" = "Y" ] || [ "${key}" = "N" ]; do
		echo $'\n Please enter a valid option :'
			read version
    done
	if [ "${key}" = "Y" ]; then
reboot
		elif [ "${key}" = "N" ]; then
			exit 0
      fi