#!/bin/bash


# Find all .env.example files in the project
env_example_files=$(find . -type f -name '.env.example')

# Loop through each .env.example file
for env_example_file in $env_example_files; do
    # Extract the directory path
    dir_path=$(dirname "${env_example_file}")

    # Create a corresponding .env file if it doesn't exist
    env_file="${dir_path}/.env"
    if [ ! -f "$env_file" ]; then
        cp "$env_example_file" "$env_file"
        echo "Created $env_file from $env_example_file"
    else
        echo "$env_file already exists, skipping."
    fi
done

# Run the start script
./start.sh
