#!/usr/bin/env bash
shopt -s nocasematch
shopt -s extglob
:
_PWD=$(pwd)
declare ENTRY
declare TARGET


# bsdvgnu() {
#     # test for GNU v. BSD stat
#     if ! command -v stat
#     then
#         printf '%s\n' "stat not found!"; exit
#     fi

#     if stat -F >/dev/null 2>&1
#     then
#         _STAT='stat -f '%i'' && return
#     fi

#     _STAT='stat -c '%i'' && return
# }
# bsdvgnu


verifyPath() {

    # test if variable is defined and non-null
    [[ -z "${!1}" ]] && \
        printf 'Path variable %s cannot be zero length!\n' "${1}" && exit 1

    local TMP_FILE; TMP_FILE="${!1}"
    local TMP_DIR; TMP_DIR="$(dirname "${!1}")"
    :
    local FILE
    local DIR
    :
    if [[ $1 == 'ENTRY' || $1 == 'TARGET' ]]
    then
        [[ ! "${!1}" = /* ]] && \
            printf '%s\n' "The base directory ENTRY path must be absolute!" && exit 1
        DIR="${TMP_DIR}" FILE="${TMP_FILE}"
        :
        [[ ! -d $DIR ]] && \
            printf 'The base directory "%s" must exist!\n' "${DIR}" && exit 1
        :
        [[ ! -w $DIR ]] && \
            printf 'The base directory "%s" must be writable!\n' "${DIR}" && exit 1
        :
    fi

    [[ $1 == 'ENTRY' && ! -f $FILE ]] && printf 'The ENTRY file "%s" must exist!\n' "${FILE}" exit 1

    [[ $1 == 'TARGET' && ! -f $FILE ]] && TARGET="${DIR}/input.processed"
    [[ $1 == 'TARGET' && -f $FILE ]] && TARGET="${FILE%%+(/)}"

    # test is relative or absolute
    # if [[ "${!1}" = /* ]];then
    #     DIR="${TMP_DIR}"
    #     FILE="${TMP_FILE}"
    # else
    #     DIR="/${_PWD}/${TMP_DIR}";
    #     FILE="/${_PWD}/${TMP_FILE}";
    # fi
    # DIR="${DIR//\/\//\/}"
    # FILE="${FILE//\/\//\/}"

    # # test if directory exists
    # [[ ! -d $DIR ]] && \
        #     printf 'The base directory "%s" must exist\n!' "${DIR}" exit 1

    # # test if directory is writeable
    # [[ ! -w $DIR ]] && \
        #     printf 'The base directory "%s" must be writable!\n' "${DIR}" exit 1

    # # test if entry is absolute
    # [[ $1 == 'ENTRY' && ! "${!1}" = /* ]] && \
        #     printf '%s\n' "The base directory ENTRY path must be absolute!" exit 1



    # if [[ $1 == 'ENTRY' ]]
    # then
    #     if [[ "${!1}" = /* ]];then
    #         DIR="${TMP_DIR}"
    #         FILE="${TMP_FILE}"
    #     else
    #         exit 1
    #     fi
    #     DIR="${DIR//\/\//\/}"
    #     FILE="${FILE//\/\//\/}"
    #     # test if directory exists
    #     if [[ ! -d $DIR ]]; then
    #         printf 'The base directory "%s" must exist\n!' "${DIR}"
    #         exit 1
    #     fi
    #     # test if directory is writeable
    #     if [[ ! -w $DIR ]]; then
    #         printf 'The base directory "%s" must be writable!\n' "${DIR}"
    #         exit 1
    #     fi
    # else
    #     exit 1
    # fi


    #     [[ ! -f $FILE ]] && printf 'The file "%s" must exist!\n' "${FILE}" && exit 1
    #     ENTRY="${FILE}"
    # elif [[ $1 == 'TARGET' ]]; then
    #     if [[ -d $1 ]]; then
    #         TARGET="${DIR}/input.processed"
    #     else
    #         TARGET="${FILE%%+(/)}"
    #     fi
    # fi
    return 0
}
printf '>>> %s\n' "Target point is ALWAYS treated as relative to the ENTRY!"

verifyPath ENTRY; printf 'Target point: %s\n' "${ENTRY}"
:

TARGET="$(dirname "${ENTRY}")/${TARGET}"
:
verifyPath TARGET; printf 'Target point: %s\n' "${TARGET}"








exit
install -b -m 755 /dev/null "${TARGET}"
BUILD_BASE=$(dirname "${ENTRY}")
:
while read -ra words
do
    [[ ${words[*]} == '# ENDBUILD' ]] && break
    if [[ ${words[0]} == source ]];then
        eval cat "${BUILD_BASE}/${words[1]}"
        printf '%s' $";"
    else printf '%s\n' "${words[*]}"
    fi
done < "${ENTRY}" >| "${TARGET}"

printf 'Check "%s" for your output.\n' "$(dirname "${TARGET}")"
