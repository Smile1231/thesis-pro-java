length_rank=`less ./sgRNA/raw.txt-rank.fa|grep -v '>'|awk '{print length($0)}'`

less ./all_txt/raw.txt|awk -F '\t' '$1 ~ /seed/'|awk -F '\t' '{print $1"\t"$2"\t"$3"\t"$4}'> raw.txt-1
less raw.txt-1|awk -F 'seed' '{print $1"\t"length($1)}'  > raw.txt-2
paste raw.txt-1 raw.txt-2 |awk -F '\t' '{print $5"\t"$6"\t"$1"\t"$2"\t"$3"\t"$4}' >raw.txt-3
less raw.txt-3|awk -F '\t' '{print "str="$5"; echo ${str:("$2"-10):('$length_rank'+20)}"}'|bash > raw.txt-4
less raw.txt-3|awk -F '\t' '{print "seed""\t""raw.txt_Seq_"NR"\t"$2"\t"$2+19"\t"$6"\t"$4}' > raw.txt-9
paste raw.txt-4 raw.txt-9|grep '-' > raw.txt-12
for i in `less raw.txt-12|cut -f7`;do grep -w $i ./all_txt/raw.txt; done > raw.txt.deletion
find . -name "raw.txt*" -type f -size 0c | xargs -n 1 rm -f
if [ -s raw.txt.deletion ] ; then 
  datamash sum -W 4 < raw.txt.deletion |awk '{print $0"\t""deletion"}' > raw.txt.deletion.num
else
  echo "0 deletion"|sed 's/ /\t/g' > raw.txt.deletion.num
fi

seqkit seq rank.fa -w 0 |grep -v '>' > raw.txt.rank
less raw.txt.rank|awk -F 'seed' '{print $1"\t"length($1)}'  > raw.txt-2
paste raw.txt.rank raw.txt-2 |awk -F '\t' '{print $1"\t"$2"\t"$3}' >raw.txt-3

header=`less raw.txt-3|awk -F '\t' '{print "str="$1"; echo ${str:("$3"-10):10}"}'|bash`
tailer=`less raw.txt-3|awk -F '\t' '{print "str="$1"; echo ${str:("$3"+'$length_rank'):10}"}'|bash`

less ./all_txt/raw.txt|awk -F '\t' '$1 ~ /'$header'/'|mawk -F ''$header'' '{print $2}'\
|mawk -F ''$tailer'' '{print $1"\t"$2}'|grep '-'|grep -v 'seed'|awk '{print $1"\t"$3}' > raw.txt-13
for i in `less raw.txt-13|cut -f2`;do grep -w $i ./all_txt/raw.txt; done > raw.txt.insertion
find . -name "raw.txt*" -type f -size 0c | xargs -n 1 rm -f
if [ -s raw.txt.insertion ] ; then 
  datamash sum -W 4 < raw.txt.insertion |awk '{print $0"\t""insertion"}' > raw.txt.insertion.num
else
  echo "0 insertion"|sed 's/ /\t/g' > raw.txt.insertion.num
fi

datamash sum -W 4 < ./all_txt/raw.txt |awk '{print $0"\t""Sum"}' > raw.txt.Sum.num
paste raw.txt.deletion.num raw.txt.insertion.num raw.txt.Sum.num |awk '{print 100*($1+$3)/$5"%""\t"$0"\t""raw.txt"}'|sed 's/.txt//g' > raw.txt.indel.prop

unset length_rank
unset header
unset tailer
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-9
rm raw.txt-12
rm raw.txt.deletion
rm raw.txt.deletion.num
rm raw.txt.rank
rm raw.txt-13
rm raw.txt.insertion
rm raw.txt.insertion.num
rm raw.txt.Sum.num
