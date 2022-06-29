less ./all_txt/raw.txt|awk -F '\t' '$1 ~ /seed/'|awk -F '\t' '{print $1"\t"$2"\t"$3"\t"$4}'> raw.txt-1
less raw.txt-1|awk -F 'seed' '{print $1"\t"length($1)}'  > raw.txt-2
paste raw.txt-1 raw.txt-2 |awk -F '\t' '{print $5"\t"$6"\t"$1"\t"$2"\t"$3"\t"$4}' >raw.txt-3
less raw.txt-3|awk -F '\t' '{print "str="$5"; echo ${str:"$2":20}"}'|bash > raw.txt-4
less raw.txt-3|awk -F '\t' '{print "seed""\t""raw.txt_Seq_"NR"\t"$2"\t"$2+19"\t"$6}' > raw.txt-9
paste raw.txt-4 raw.txt-9  |grep -v '-' > raw.txt-11
less raw.txt-4 |awk '{print $1}' |sort|uniq -c|awk '{if ($1>=10) print $0}'|wc -l |awk '{print "raw.txt""\t"$0}'  > raw.txt_mutation_count

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-9
rm raw.txt-11



