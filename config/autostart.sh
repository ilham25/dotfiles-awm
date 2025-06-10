#!/bin/bash

start_and_kill() {
    local cmd="$1"
    local proc_name="${cmd%% *}"  # get first word as process name
    pkill -u "$USER" -x "$proc_name"
    $cmd &
}

start_and_kill connman-gtk
start_and_kill picom
