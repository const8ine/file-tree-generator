#!/bin/bash

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Check if the input file parameter is provided
if [ $# -eq 0 ]; then
    # Use "tree.txt" as the default input file if not provided
    input_file="tree.txt"
else
    # Get the input file name from the command-line argument
    input_file="$1"
fi

# Function to create a directory and files based on the input tree structure
create_files() {
    local path=$1
    local input_file=$2

    while IFS= read -r line || [[ -n $line ]]; do
        # Ignore empty lines or lines starting with #
        [[ "$line" =~ ^[[:space:]]*$ || "$line" =~ ^[[:space:]]*# ]] && continue

        # Count leading spaces to determine the level
        local level=0
        local temp_line="$line"
        while [[ "$temp_line" == "  "* || "$temp_line" == "|   "* || "$temp_line" == "|" ]]; do
            temp_line="${temp_line#  }"
            temp_line="${temp_line#|   }"
            temp_line="${temp_line#|}"
            ((level++))
        done

        # Remove leading symbols indicating the tree structure
        line="${line/|-- /}"
        line="${line/|   /}"
        line="${line/|/}"
        line="${line/-- /}"

        # Check if the line ends with .<extension>
        if [[ $line == *"/"* ]]; then
            # It's a directory
            local directory_name=$(echo "$line" | sed 's/^[[:space:]]*//')
            mkdir -p -- "$path/$directory_name"
        else
            # It's a file
            local file_name=$(echo "$line" | tr -d '[:space:]')
            # Check if it has an extension
            if [[ "$file_name" != *.* ]]; then
                file_name="$file_name.txt"
            fi
            touch -- "$path/$file_name"
        fi
    done < "$input_file"
}

# Use the current directory as the root directory
root_directory="."
mkdir -p "$root_directory"

# Create the file and folder structure based on the provided or default input file name
create_files "$root_directory" "$input_file"
