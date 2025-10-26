#!/usr/bin/bash

function print_help() {
    echo "Usage: genconf.sh NODE [options]"
    echo "Options:"
    echo "  -W, --worker          Output type worker"
    echo "  -C, --controlplane    Output type controlplane"
    echo "  -h, --help            Display this help message"
    exit 1
}

function main() {
    if [[ "${1}" == "" ]]; then
        print_help
    fi

    local node out_type
    for arg in "${@}"; do
        case "${arg}" in
        "--worker" | "-W")
            out_type="worker"
            ;;
        "--controlplane" | "-C")
            out_type="controlplane"
            ;;
        "--help" | "-h")
            print_help
            ;;
        *)
            node="${arg}"
            ;;
        esac
    done

    k8s_version=$(yq -r .kubernetesVersion cluster.yaml)
    talos_version=$(yq -r .talosVersion cluster.yaml)
    cluster_addr=$(yq -r .clusterAddress cluster.yaml)
    cluster_name=$(yq -r .clusterName cluster.yaml)

    declare -a args
    args=("--with-secrets=secrets.yaml"
        "--kubernetes-version=${k8s_version}"
        "--talos-version=${talos_version}"
        "--config-patch=@patches/common.yaml"
        "--config-patch=@patches/${out_type}.yaml"
        "--config-patch=@patches/nodes/${node}.yaml"
        "--with-docs=false"
        "--force"
        "--output-types=${out_type}"
        "--output=${node}.yaml"
    )

    talosctl gen config "${cluster_name}" "${cluster_addr}" "${args[@]}"
}

main "${@}"
