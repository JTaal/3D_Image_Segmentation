#!/bin/bash

# Function to download and extract files
download_and_extract() {
    echo "Downloading and extracting files..."

    # URL of the file to download
    url="https://filesender.surf.nl/download.php?token=2cfcce3a-7c7d-43ac-824f-b232c409d61d&files_ids=20213963,20213965,20213967,20213969,20213971,20213973,20213975,20213977,20213979,20213981"

    # Destination file path
    zipfile="downloaded.zip"

    # Download the file
    curl -L "$url" -o "$zipfile"

    # Verify download and extract
    echo "Verifying download..."
    if unzip -t "$zipfile" &> /dev/null; then
        echo "Extracting files..."
        unzip "$zipfile"
        # Optional: remove the ZIP file after extraction
        # rm "$zipfile"
    else
        echo "Failed to download ZIP file. Please check the URL or your network connection."
    fi
}

# Ask user if they want to download the file
echo "Do you want to download the .tif training files? [Y/N]"
read -p "Press Y for Yes or N for No: " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    download_and_extract
fi

echo "Proceeding with environment setup..."

# Get the name of the parent directory
PARENT_FOLDER_NAME=$(basename "$PWD")

# Check if virtualenv is installed, if not install it (not required for Python 3.3+)
# Uncomment the line below if necessary
# pip install virtualenv

# Create the virtual environment with the parent folder's name
python -m venv "$PARENT_FOLDER_NAME"

# Activate the virtual environment
# Windows and Unix/Linux have different paths for the activate script
if [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32"* ]]; then
    source "$PARENT_FOLDER_NAME/Scripts/activate"
else
    source "$PARENT_FOLDER_NAME/bin/activate"
fi

# Install dependencies from requirements.txt
pip install -r requirements.txt

echo "Environment setup complete."

# Start Jupyter Notebook server
echo "Starting Jupyter Notebook..."
jupyter notebook
