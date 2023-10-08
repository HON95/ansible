#!/bin/bash

# Script to add more elements to a space separated shell list.
# Example: GRUB_CMDLINE_LINUX="abc=123"

set -eu

if [[ $# < 2 ]]; then
    echo "Not enough arguments." >&2
    exit 1
fi

file_path="$1"
var_id="$2"
new_values_str="${@:3}"

if [[ ! -f $file_path ]]; then
    echo "File does not exist." >&2
    exit 1
fi

old_values_str="$(grep -Po "(?<=^${var_id}=\").*(?=\"$)" "$file_path" | tail -n1)"
old_values_arr=($old_values_str)

output_list="$old_values_str"
for value in $new_values_str ; do
    if [[ " ${old_values_arr[@]} " =~ " ${value} " ]]; then
        continue
    fi
    if [[ $output_list == "" ]]; then
        output_list="$value"
    else
        output_list="$output_list $value"
    fi
done

output_line="${var_id}=\"${output_list}\""
sed -i "0,/^${var_id}=.*$/s//${output_line}/" "$file_path"
