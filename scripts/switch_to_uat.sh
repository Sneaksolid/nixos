export OLD_PS1=$PS1
export PS1="(UAT) $PS1"
export KUBECONFIG=$HOME/.kube/config_uat

kubectl config set-context trever-uat > /dev/null

function revert() {
    export PS1=$OLD_PS1
    unset KUBECONFIG
    unset -f revert
    unalias exit
}

alias exit=revert
