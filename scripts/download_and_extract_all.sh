#!/bin/bash

info() {
  printf "\r  [\033[00;34mINFO\033[0m] %s\n" "$1"
}

fail() {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] %s\n" "$1"
  echo ''
  exit
}

main() {
  DEST=${1:-wikiasp}
  PREFIX="http://phontron.com/download/wikiasp"

  mkdir -p "$DEST"
  info "Saving to $DEST"

  DOMAINS=(Album Animal Artist Building Company EducationalInstitution Event Film Group
    HistoricPlace Infrastructure MeanOfTransportation OfficeHolder Plant Single
    SoccerPlayer Software TelevisionShow Town WrittenWork)

  for DOM in "${DOMAINS[@]}"; do
    TEMP_TARGET="wikiasp_temp_downloaded_${DOM}.tar.bz2"
    wget -O "${TEMP_TARGET}" "$PREFIX/${DOM}.tar.bz2"
    if [ ! -e "${TEMP_TARGET}" ]; then
      fail "Could not download."
    fi
    info "Extracting $DOM data..."
    tar xjvf "${TEMP_TARGET}"
    mv "${DOM}" "$DEST"
    rm -f "${TEMP_TARGET}"
  done

  info "All downloads and extraction are done at $DEST."
}

main "$@"
