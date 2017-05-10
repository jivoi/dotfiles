#! /usr/bin/env bash

rmmod usbcore
sleep 5
modprobe usbcore
