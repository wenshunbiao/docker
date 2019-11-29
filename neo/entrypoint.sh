#!/bin/bash
PROMPT_OPTS=()
BOOTSTRAP_OPTS=()
BOOTSTRAP=""
MAIN_NET=""
PRIV_NET=""
COZ_NET=""

echo "$1"

while [ -n "$1" ]; do
    case "$1" in
        -m|--mainnet)
            PROMPT_OPTS+="-m"
            BOOTSTRAP_OPTS+="-m"
            MAIN_NET="-m"
        ;;
        -p|--privnet)
            PROMPT_OPTS+="-p"
            PRIV_NET="-p"
        ;;
        --coznet)
            PROMPT_OPTS+="--coznet"
            COZ_NET="--coznet"
        ;;
        -c|--config)
            if [[ "$MAIN_NET" == "-m" ]]; then
                echo "Can not use config file on main net, proceeding without config file.."
            else
                shift
                PROMPT_OPTS+="-c=$1"
                BOOTSTRAP_OPTS+="-c=$1"
            fi
        ;;
        -t|--set-default-theme)
            shift
            PROMPT_OPTS+="-t=$1"
        ;;
        --version)
            shift
            PROMPT_OPTS+="--version=$1"
        ;;
        --bootstrap)
            if [[ "$PRIV_NET" == "-p" ]]; then
                echo "Can not bootstrap on private net, proceeding without bootstrapping.."
            elif [[ "$COZ_NET" == "--coznet" ]]; then
                echo "Can not bootstrap on coz net, proceeding without bootstrapping.."
            else
                BOOTSTRAP="$1"
            fi
        ;;
        -n|--notifications)
            if [[ -z "$BOOTSTRAP" ]]; then
                echo "-n / --notifications option can only be used when --bootstrap is used."
            else
                BOOTSTRAP_OPTS+="-n"
            fi
        ;;
        esac
        shift
done

rm -rf /neo-python/Chains/privatenet
if [ ! -d "/neo-python/Chains/SC234" ] && [ ! -z "$BOOTSTRAP" ]; then
  python3 /neo-python/bootstrap.py --skipconfirm "${BOOTSTRAP_OPTS[@]}"
fi

screen python3 /neo-python/prompt.py "${PROMPT_OPTS[@]}"
