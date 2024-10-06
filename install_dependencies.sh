#!/bin/bash
# install_dependencies.sh

# Step 1: Install PyMySQL to the Lambda layer directory
echo "Installing PyMySQL..."
pip install "pymysql>=1.1.1" -t src/layers/pymysql/python

# Step 2: Zip the contents of the layer directory
echo "Zipping the PyMySQL layer..."
cd src/layers/pymysql || exit
zip -r ../pymysql-layer.zip python

# Step 3: Output success message
echo "PyMySQL layer built and zipped successfully."