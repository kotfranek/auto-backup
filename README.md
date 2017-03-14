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

## Requirements
Installed [rsync][20] (default option for most of the Linux distributions). 

## Copyright
Copyright &copy; 2017 [Przemysław Podwapiński][98].<br>
Distributed under the [Simplified BSD License][99].

[20]:https://rsync.samba.org/
[98]:mailto:p.podwapinski@gmail.com
[99]:https://www.freebsd.org/copyright/freebsd-license.html
