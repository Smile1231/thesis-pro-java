#!/bin/bash -x

function zipAction() {
    echo "####### start zip result!#######"
    # shellcheck disable=SC2034
    # computation/189oe3c/
    local computation_directory=$1;
    # shellcheck disable=SC2164
    cd "$computation_directory"
    # shellcheck disable=SC2034
    local zip_file_name=$2
    zip -r "$zip_file_name" all_* all-* mutation_count.all table.all total.summary
    echo "####### end zip result!#######"

    internet_connect
}

cd ../../
# resources directory
zipAction "$1" "$2"
