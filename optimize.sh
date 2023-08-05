#!/bin/bash

# Step 1: Find all images recursively in the current directory
image_files=($(find . -type f -name "*.jpg"))
image_count=${#image_files[@]}
current_image=0

for image_file in "${image_files[@]}"
do
    ((current_image++))
    echo -ne "Processing image $current_image of $image_count ($((current_image * 100 / image_count))%)\n"

    # Step 2: Process the image using the specified command
    output_image_file=$(basename "$image_file" .jpg)_processed.jpg
    ~/forked-programs/pio/pio-x86_64-unknown-linux-gnu "$image_file" --quality 50 --output "$output_image_file"
    
    # Step 3: Remove the original image
    rm "$image_file"
    
    # Step 4: Rename the processed image to the original one
    mv "$output_image_file" "$image_file"
done

echo -e "\nImage processing completed."
