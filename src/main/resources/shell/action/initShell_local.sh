#!/bin/bash

# shellcheck disable=SC2120
function init() {
    local gz_file_name=$1;
    local gz_file_path=$2;
    local xlsx_file_name=$3;
    local xlsx_file_path=$4;
    local computation_file=$5
    # shellcheck disable=SC2034
    local target_dir=computation/"$computation_file"
    # shellcheck disable=SC2164
    mkdir "$target_dir"
    if [ -d "computation" ];then
      # shellcheck disable=SC2006
      echo "############## root dir is `pwd` ,computation directory exist!, then move source shell to this directory ##########"
      cp shell/local/* "$target_dir"
      chmod 777 "$target_dir/coreCalFile.sh"
    else
      echo "############## computation directory not exist! ##############"
      return
    fi
    # find target file copy to com/
    echo "############copy gz file and xlsx file to computation##############"
    cp "$gz_file_path" "$target_dir/"
    mkdir "$target_dir/test_NGS_data/"
    #tar -zxf "$target_dir/$gz_file_name" -C "$target_dir/test_NGS_data/"
    unzip -d "$target_dir/test_NGS_data/" "$target_dir/$gz_file_name"
    # shellcheck disable=SC2045
    for x in $(ls ./"$target_dir/test_NGS_data/");do
#        mv "$target_dir"/test_NGS_data/"$x"/* "$target_dir"/test_NGS_data
#        rm -rf "$target_dir"/test_NGS_data/"$x"
        if [ -d "$target_dir/test_NGS_data/$x" ]; then
            rm -rf "$target_dir"/test_NGS_data/"$x"
        fi
    done
    # shellcheck disable=SC2115
    rm -rf "$target_dir/$gz_file_name"
    #    mv  "$target_dir/test_NGS_data/"
    cp "$xlsx_file_path" "$target_dir/"
    mv "$target_dir/$xlsx_file_name" "$target_dir/test_info.xlsx"
    # step into dataUse
#    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#        . "/opt/anaconda3/etc/profile.d/conda.sh"
#    else
#       export PATH="/opt/anaconda3/bin:$PATH"
#    fi
#    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
#           . "/opt/anaconda3/etc/profile.d/conda.sh"
#    else
#      export PATH="/opt/anaconda3/bin:$PATH"
#    fi
#    conda activate dateUse
#    conda list
}
# cd classpath directory
cd ../../
# move cal directory file to computation
#init "bb57aae49d67496f8117ecbab9256334.fq.gz" "upload/bb57aae49d67496f8117ecbab9256334.fq.gz" "e03b1340d87445d796b4899feddd222c.xlsx" "upload/e03b1340d87445d796b4899feddd222c.xlsx"
init "$1" "$2" "$3" "$4" "$5"
