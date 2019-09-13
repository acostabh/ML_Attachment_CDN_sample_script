# Skills Membership - Sample Shell Script - Mac/Linux Version #

This shell script (Mac/Linux) uses a Mavenlink API endpoint to upload file attachment via the Direct CDN Upload.

Disclaimer: These scripts are provided as sample code and they are NOT official Mavenlink tools, but generated as part of an exercise to investigate the use of Mavenlink's API based on specific scenarios. The developer accepts no liability for any issues that could arise from using these scripts.

## Pre-Requisites ##

  1. Make the shell scripts executable
      - Navigate to the folder where you cloned the scripts (E.G: cd ~/Documents/ML-file-upload-sample-script)
      - Run this code (inside that folder only): chmod +x attach.sh
  2. Linux: Install JQ via your distribution's application manager. eg: apt-get install jq
  3. Mac: Install the Homebrew Package Manager and the JQ JSON parser/compiler for Shell scripting
     - run the setup script: ./setup.sh (follow the prompts)
  4. Rename the file sample_token.json to token.json and update it with with your Mavenlink API token

## Data Prep ##

  1. Copy the file you want to upload into the same folder as the scripts
  2. Update the attach.sh script, setting the variable file="your_file.name"

## Running the script ##

  1. Open terminal
  2. Navigate to the folder where you saved the script
    - E.G: cd ~/Documents/ML-file-upload-sample-script
  3. Run the script: ./attach.sh
  4. Follow the output on the prompt - if successful you will see a JSON formatted response with the new URL for the attachment
