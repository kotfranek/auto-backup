# auto-backup
Data backup automation shell script

## Usage
auto-backup.sh -i < list_file > -o < output_dir > [-v]

### Options
|parameter|argument|description|
|---|---|---|
|-i|< list_file >|file containing list of files and folders for backup|
|-o|< output_dir >|set the output location|
|-v||be verbose|

### Remarks
The input file contains the list of items to backup.
Only one item per line.
