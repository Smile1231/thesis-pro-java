############################################################################################################################################

# step into dataUse
if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
    . "/opt/anaconda3/etc/profile.d/conda.sh"
else
   export PATH="/opt/anaconda3/bin:$PATH"
fi
if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
       . "/opt/anaconda3/etc/profile.d/conda.sh"
else
  export PATH="/opt/anaconda3/bin:$PATH"
fi
conda activate dateUse

#input的test_info.xlsx转为txt格式，输出为test_info.txt
# f809d7ae27b74e82bee6aedb8d3246a1.xlsx 的表头有改变。
python excel_to_txt.py
less test_info.txt|grep -v '^#'|awk '{print $1"\t""amplicon_"NR"\t"$2"\t"$3}' > fastq-sg-target-info
less fastq-sg-target-info |awk '{print $2"\t"$3}'|uniq|awk '{print ">"$1"\n"$2}' > 1.fa
faSplit byname 1.fa ./
rm 1.fa
mkdir raw_fastq 
cp ./test_NGS_data/*.gz ./raw_fastq/ 
rm test_info.txt
############################################################################################################################################

############################################################################################################################################
# 计算每个fastq和full seq的比对结果。
# 1.分别计算每个位点
rm change.sh 
awk '{print "sed '\''s/fastq_id/"$1"/g'\'' kim-txt-generate-pipeline.sh > kim-"$1".sh"}' fastq-sg-target-info >>change.sh
awk '{print "sed -i '\''s/full_sequence/"$3"/g'\'' kim-"$1".sh" }' fastq-sg-target-info >>change.sh
awk '{print "sed -i '\''s/rank/"$2"/g'\'' kim-"$1".sh  " }' fastq-sg-target-info >>change.sh
bash change.sh 
rm change.sh 
awk '{print "bash kim-"$1".sh;rm kim-"$1".sh" }' fastq-sg-target-info > make-list.sh
lines=`wc -l make-list.sh|awk '{print int($1/80)+1}'`
split -$lines make-list.sh
rm change.sh 
rm make-list.sh
for i in `ls x*`; do 
    bash "$i"
    rm "$i"
done
#2.将单个的结果存入一个文件夹。
unset lines
mkdir all_txt
mv *.txt ./all_txt/
less  fastq-sg-target-info |awk '{print "rm "$2".fa"}' |bash
############################################################################################################################################

############################################################################################################################################
#准备target.info.2文件，很重要，反复检查
####例子：hitomcl500split_RH_F10.txt	21	TACCCACAGTGCTTCATGAG	1397	171778
for i in `less  fastq-sg-target-info|awk '{print $1}'`; do wc -l ./all_txt/$i.txt|awk '{print $1"\t""'$i'"}';done |sort -k2 > lines
for i in `less  fastq-sg-target-info|awk '{print $1}'`; do datamash sum -W 4 < ./all_txt/$i.txt|awk '{print $1"\t""'$i'"}';done|sort -k2 > counts
cat lines counts|cut -f2|sort|uniq -d  > lines.counts.common
for i in `less lines.counts.common`;do grep -w $i lines;done > lines.1241
for i in `less lines.counts.common`;do grep -w $i counts;done > counts.1241
for i in `less lines.counts.common`;do grep -w $i fastq-sg-target-info;done > fastq-sg-target-info.1241
paste fastq-sg-target-info.1241  lines.1241 counts.1241|awk '{print $1".txt""\t"$2"\t"$4"\t"$5"\t"$7}' |awk '{if ($4>100) print $0}' > target.info.2
less target.info.2 |awk '{print $1"-"$2"\t"$3}'|uniq|awk '{print ">"$1"\n"$2}' > target.info.2.fa
mkdir sgRNA
faSplit byname target.info.2.fa ./sgRNA/
rm target.info.2.fa
rm counts
rm lines
rm fastq-sg-target-info.1241  
rm lines.1241 
rm counts.1241
rm lines.counts.common
############################################################################################################################################


############################################################################################################################################
#计算indel。
#1.分别计算每个位点
rm change.sh 
awk '{print "sed '\''s/seed/"$3"/g'\'' seed_indel.sh > indel_"$1".sh "}' target.info.2 >>change.sh
awk '{print "sed -i '\''s/raw.txt/"$1"/g'\'' indel_"$1".sh  " }' target.info.2 >>change.sh
awk '{print "sed -i '\''s/rank/"$2"/g'\'' indel_"$1".sh  " }' target.info.2 >>change.sh
bash change.sh 
rm change.sh 
for i in `ls indel_*.sh`; do bash $i;rm $i;done
cat *.prop > indel.proporation
#3.将单个的结果存入一个文件夹。
mkdir all_prop
mv *.prop ./all_prop/
ls ./*/*.gz|sed 's/\//\t/g'|grep -v 'raw_fastq'|sed 's/.R1.fq.gz//g'|sed 's/.R2.fq.gz//g'|sed 's/-/_/g'| uniq > 1
for i  in `less indel.proporation|cut -f8`;do grep -w $i 1;done > 2
paste indel.proporation 2 > 3
cp 3 indel.proporation
rm 1
rm 2
rm 3
############################################################################################################################################


############################################################################################################################################
# 计算>=2个碱基同时突变的概率。
# 1.分别计算每个位点
rm change.sh 
awk '{print "sed '\''s/seed/"$3"/g'\'' edit_efficiency_cal_AG_CT.sh > "$1".sh "}' target.info.2 >>change.sh
awk '{print "sed -i '\''s/raw.txt/"$1"/g'\'' "$1".sh  " }' target.info.2 >>change.sh
awk '{print "sed -i '\''s/rank/"$2"/g'\'' "$1".sh  " }' target.info.2 >>change.sh
awk '{print "sed -i '\''s/file-line/"$4"/g'\'' "$1".sh  " }' target.info.2 >>change.sh
awk '{print "sed -i '\''s/total-count/"$5"/g'\'' "$1".sh  " }' target.info.2 >>change.sh
bash change.sh 
awk '{print "bash "$1".sh;rm "$1".sh" }' target.info.2 |sort -R > make-list.sh
lines=`wc -l make-list.sh|awk '{print int($1/80+1)}'`
split -$lines make-list.sh
rm change.sh 
rm make-list.sh
for i in `ls x*`; do 
    bash "$i"
    rm "$i"
done

#2.多个位点合并
ls *txt-base-combine-summary|awk -F '.' '{print $1}' >1
for i in `ls *.txt-base-combine-summary`; do awk '{print $1}' $i|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]" "$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}' ;done >2
paste 1 2 >3
for i in `less 3|cut -f1`;do grep -w $i  target.info.2;done|cut -f2 > 3.1
paste 3.1 3|sed 's/ /\t/g' > 5
header=`ls *-combine-summary|head -n 1`
headername=`ls *-combine-summary|head -n 1|awk -F '-' '{print $1}'`
head -n 15 $header |awk '{print $2}'|sed 's/'$headername'_//g'|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]" "$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|awk '{print "sgRNA""\t""Sample""\t"$0}' |sed 's/ /\t/g' > 4
cat 4 5  |sort -k1n > total.summary
rm 3.1
rm 5
rm 1;rm 2;rm 3;rm 4
#3.将单个的结果存入一个文件夹。
mkdir all-base-combine-summary
mv *-base-combine-summary ./all-base-combine-summary/
mkdir all-location
mv *-location ./all-location/
############################################################################################################################################


############################################################################################################################################
#illumina测序结果中有多少种突变类型，只计算20bp.
#1.分别计算每个位点
rm change.sh 
awk '{print "sed '\''s/seed/"$3"/g'\'' mutation_count.sh > mutation_count."$1".sh "}' target.info.2 >>change.sh
awk '{print "sed -i '\''s/raw.txt/"$1"/g'\'' mutation_count."$1".sh  " }' target.info.2 >>change.sh
bash change.sh 
awk '{print "bash mutation_count."$1".sh;rm mutation_count."$1".sh" }' target.info.2 > make-list.sh
lines=`wc -l make-list.sh|awk '{print int($1/80+1)}'`
split -$lines make-list.sh
rm change.sh 
rm make-list.sh
for i in `ls x*`; do 
    bash "$i"
    rm "$i"
done

#2.多个位点合并，将单个的结果存入一个文件夹。
cat  *_count > mutation_count.all
mkdir all_count
mv *_count ./all_count/
############################################################################################################################################


############################################################################################################################################
#20*4中的突变率
#1.分别计算每个位点
rm change.sh 
awk '{print "sed '\''s/raw.txt/"$1"/g'\'' site_efficiency_4_20.sh > table."$1".sh "}' target.info.2 >>change.sh
awk '{print "sed -i '\''s/rank/"$2"/g'\'' table."$1".sh  " }' target.info.2 >>change.sh
bash change.sh 
rm change.sh 
for i in `ls table*.sh`; do echo "bash $i;rm $i";done |parallel
#2.多个位点合并，将单个的结果存入一个文件夹。
cat  *-table > table.all
mkdir all-table
mv *-table ./all-table/
mkdir all_site-efficiency
mv *-site-efficiency ./all_site-efficiency/
############################################################################################################################################
rm *.fa 


