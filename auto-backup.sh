# !/bin/sh

# Copyright (c) Przemysław Podwapiński <p.podwapinski@gmail.com>
#
# Distributed under the terms of the Simplified BSD License.
# For details, please see attached LICENSE.md file, or visit
# <https://www.freebsd.org/copyright/freebsd-license.html>.

# Make automatic backup of files and directories listed in a text file.
# Use 'rsync' for data transfering.
#


### Constant definitions ######################################################

# Script name
readonly SCRIPT_NAME=`basename "$0"`

# Script full name
readonly SCRIPT_NAME_FULL="Auto Backup"

# Version
readonly SCRIPT_VERSION="0.1.0"

# exit status values
readonly EXIT_SUCCESS=0 # successfull program execution
readonly EXIT_ERR_OPT=1 # invalid command line options

# Usage/help message
readonly HELP_MESSAGE="USAGE:

${SCRIPT_NAME} -i <list_file> -o <output_dir> [-v]

OPTIONS:
-i <list_file>		file containing list of files and folders for backup
-o <output_dir>		set the output location
-v 			be verbose

REMARKS:
The input file contains the list of items to backup.
Only one item per line.

"
### Global Variables ##########################################################

# Verbosity flag
GLOB_VERBOSE=0
GLOB_INPUT_FILE=""
GLOB_OUTPUT=""

### Functions #################################################################

# Read the command line options and set the global variables
# ext   INPUT_FILE
# ext   OUTPUT_LOCATION
getOptions() 
{
    while [[ ${#} > 0 ]]; do
        case "${1}" in
        -i|--input)
            shift
            GLOB_INPUT_FILE="${1}"
            shift
            ;;
        -o|--output)
            shift
            GLOB_OUTPUT="${1}"
            shift
            ;;
        -v|--verbosity)
            shift
            ;;
        -h|--help)
            printHelp
            exitSuccess
            ;;
        *)
            exitOptionsError
            ;;
        esac
    done
}

# Display the usage info
printHelp()
{
    printf "%s\n" "${HELP_MESSAGE}"
}

printScriptInfo()
{
    printf "%s v%s\n" "${SCRIPT_NAME_FULL}" "${SCRIPT_VERSION}"
}


# Script body
main()
{
    printScriptInfo
    printHelp
}

# Call main function with all CLI arguments
main "${@}"
