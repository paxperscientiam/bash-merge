#!/usr/bin/env bash
shopt -s nocasematch
shopt -s extglob
:
# get CWD
SOURCE="${BASH_SOURCE[-1]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
_CWD="$( cd -P "$( dirname "$SOURCE" )" && pwd )"



verifyPath() {
    declare FILE
    declare DIR

  # test if variable is defined and non-null
  [[ -z "${!1}" ]] && \
      printf 'Path variable %s cannot be zero length!\n' "${1}" && \
      exit 1

  local TMP_FILE; TMP_FILE="${!1}"
  local TMP_DIR; TMP_DIR="$(dirname "${!1}")"


  # test is relative or absolute
  if [[ "${!1}" = /* ]];then
    :
  else
      DIR="/${_CWD}/${TMP_DIR}"; DIR="${DIR//\/\//\/}"
      FILE="/${_CWD}/${TMP_FILE}"; FILE="${FILE//\/\//\/}"
  fi

  # test if directory exists
  if [[ ! -d $DIR ]]; then
    printf 'The base directory "%s" must exist\n!' "${DIR}"
    exit 1
  fi
  # test if directory is writeable
  if [[ ! -w $DIR ]]; then
    printf 'The base directory "%s" must be writable!\n' "${DIR}"
    exit 1
  fi

  if [[ $1 == 'ENTRY' ]]; then
      [[ ! -f $FILE ]] && printf 'The file "%s" must exist!\n' "${FILE}" && exit 1
      ENTRY="${FILE}"
  elif [[ $1 == 'TARGET' ]]; then
      if [[ -d $1 ]]; then
          TARGET="${DIR}/input.processed"
      else
          TARGET="${FILE%%+(/)}"
      fi
  fi
  return 0
}

verifyPath ENTRY; echo "${ENTRY}"
verifyPath TARGET; echo "${TARGET}"

:
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
