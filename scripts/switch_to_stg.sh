export OLD_PS1=$PS1
export PS1="(STG) $PS1"
export KUBECONFIG=$HOME/.kube/config_stg

function revert() {
    export PS1=$OLD_PS1
    unset KUBECONFIG
    unset -f revert
    unalias exit
}

alias exit=revert
