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

# rsync binary
readonly RSYNC_BIN="rsync"

# exit status values
readonly EXIT_SUCCESS=0 # successfull program execution
readonly EXIT_ERR_OPT=1 # invalid command line options

# Error message: wrong arguments
readonly MSG_ERR_ARGS="Wrong or no arguments provided.
Execute '${SCRIPT_NAME} -h' to get the details."

# Error message: input file does not exist
MSG_ERR_INPUT="Input file '${GLOB_INPUT_FILE}' does not exist or is not readable."

# Usage/help message
readonly MSG_USAGE="USAGE:

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
GLOB_GO=""

### Functions #################################################################

exitSuccess()
{
    exit ${EXIT_SUCCESS}
}

# Exit with the given Error Code
exitError()
{
    exit ${1}
}

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
            GLOB_VERBOSE=1
            shift
            ;;
        -h|--help)
            printHelp
            exitSuccess
            ;;
        *)
            printError "${MSG_ERR_ARGS}"
            exitError ${EXIT_ERR_OPT}
            ;;
        esac
    done
}

printToConsole()
{
    printf "%s\n" "${1}"
}

# Display the usage info
printHelp()
{
    printToConsole "${MSG_USAGE}"
}

# Display the most basic information
printScriptInfo()
{
    printf "%s v%s\n" "${SCRIPT_NAME_FULL}" "${SCRIPT_VERSION}"
}

# Print the error message tp stderr
printError()
{
    printf >&2 "ERROR: %s\n" "${1}"
}

# Performs a basic check after options were parsed
checkParams()
{
    if [ -z "${GLOB_INPUT_FILE}" ]; then
        printError "Input file is missing."
    elif [ ! -e "${GLOB_INPUT_FILE}" ]; then
        printError "Input file '${GLOB_INPUT_FILE}' does not exist or is not readable."
    elif [ -z "${GLOB_OUTPUT}" ]; then
        printError "Output directory is missing."
    elif [ ! -d "${GLOB_OUTPUT}" ] || [ ! -w "${GLOB_OUTPUT}" ]; then
        printError "Output directory '${GLOB_OUTPUT}' does not exist or is not writable."
    else
        GLOB_GO="yes"
    fi
}

# Script body
main()
{
    printScriptInfo
    getOptions "${@}"
    checkParams
    if [ -z "${GLOB_GO}" ]; then
        printHelp
        exitError ${EXIT_ERR_OPT}
    else
        printToConsole "Perform a backup to "${GLOB_OUTPUT}""
    fi
}

# Call main function with all CLI arguments
main "${@}"
