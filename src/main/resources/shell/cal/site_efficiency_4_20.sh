less raw.txt-site-efficiency|awk '{print $NF}'|awk -F  '' '{print $1"\t"$2}'  > raw.txt-1
paste raw.txt-site-efficiency raw.txt-1|cut -f2,4|sort|uniq|sort -k1n|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]"\t"$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|sed 's/ //g'|awk '{print " ""\t"" ""\t"$0}' > raw.txt-2
paste raw.txt-site-efficiency raw.txt-1 > raw.txt-3

length_rank=`less ./sgRNA/raw.txt-rank.fa|grep -v '>'|awk '{print length($0)}'`

for i in `seq 1 $length_rank`;do echo $i;done > $length_rank-list

less  raw.txt-3|awk '{if ($5=="A") print $2}' > raw.txt-4
cat raw.txt-4 $length_rank-list|sort|uniq -u|awk '{print "0%""\t"$0"\t""NN""\t""N""\t""A"}' > raw.txt-5
less  raw.txt-3|awk '{if ($5=="A") print $0}' > raw.txt-6
cat raw.txt-5 raw.txt-6|sort -k2n|awk '{print $1}'|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]"\t"$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|sed 's/ //g' > raw.txt-7
less raw.txt-7|awk '{print "raw.txt""\t""A""\t"$0}' > raw.txt-A

less  raw.txt-3|awk '{if ($5=="T") print $2}' > raw.txt-4
cat raw.txt-4 $length_rank-list|sort|uniq -u|awk '{print "0%""\t"$0"\t""NN""\t""N""\t""T"}' > raw.txt-5
less  raw.txt-3|awk '{if ($5=="T") print $0}' > raw.txt-6
cat raw.txt-5 raw.txt-6|sort -k2n|awk '{print $1}'|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]"\t"$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|sed 's/ //g' > raw.txt-7
less raw.txt-7|awk '{print "raw.txt""\t""T""\t"$0}' > raw.txt-T

less  raw.txt-3|awk '{if ($5=="C") print $2}' >raw.txt-4
cat raw.txt-4 $length_rank-list|sort|uniq -u|awk '{print "0%""\t"$0"\t""NN""\t""N""\t""C"}' > raw.txt-5
less  raw.txt-3|awk '{if ($5=="C") print $0}' >raw.txt-6
cat raw.txt-5 raw.txt-6|sort -k2n|awk '{print $1}'|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]"\t"$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|sed 's/ //g' > raw.txt-7
less raw.txt-7|awk '{print "raw.txt""\t""C""\t"$0}' > raw.txt-C

less  raw.txt-3|awk '{if ($5=="G") print $2}' >raw.txt-4
cat raw.txt-4 $length_rank-list|sort|uniq -u|awk '{print "0%""\t"$0"\t""NN""\t""N""\t""G"}' > raw.txt-5
less  raw.txt-3|awk '{if ($5=="G") print $0}' >raw.txt-6
cat raw.txt-5 raw.txt-6|sort -k2n|awk '{print $1}'|awk  '{for(i=1;i<=NF;i++){if(NR == 1){a[i]=$i;}else{a[i]=a[i]"\t"$i;}}}END {for(i=1;a[i]!="";i++){print a[i];}}'|sed 's/ //g' > raw.txt-7
less raw.txt-7|awk '{print "raw.txt""\t""G""\t"$0}' > raw.txt-G
cat raw.txt-2 raw.txt-A raw.txt-T raw.txt-C raw.txt-G > raw.txt-table 

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-A
rm raw.txt-T
rm raw.txt-C
rm raw.txt-G
