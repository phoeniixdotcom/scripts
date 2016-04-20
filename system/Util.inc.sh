#!/bin/bash
pause() {
  if [ $1 -eq 0 ]; then
      echo "Success!"
  else
      echo "Error: " $1
      printf "\n"
      read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...'
  fi
      printf "\n"
}

ask() {
    # http://djm.me/ask
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question - use /dev/tty in case stdin is redirected from somewhere else
        read -p "$1 [$prompt] " REPLY </dev/tty

        # Default?
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi

        # Check if the reply is valid
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) echo "Skipping..." ; printf "\n" ; return 1 ;;
        esac
    done
}
