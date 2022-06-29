length_rank=`less ./sgRNA/raw.txt-rank.fa|grep -v '>'|awk '{print length($0)}'`

less ./all_txt/raw.txt|awk -F '\t' '$1 ~ /seed/'|awk -F '\t' '{print $1"\t"$2"\t"$3"\t"$4}'> raw.txt-1
less raw.txt-1|awk -F 'seed' '{print $1"\t"length($1)}'  > raw.txt-2
paste raw.txt-1 raw.txt-2 |awk -F '\t' '{print $5"\t"$6"\t"$1"\t"$2"\t"$3"\t"$4}' >raw.txt-3
less raw.txt-3|awk -F '\t' '{print "str="$5"; echo ${str:"$2":'$length_rank'}"}'|bash > raw.txt-4
# less raw.txt-4| awk -F '' '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17"\t"$18"\t"$19"\t"$20"\t"$21"\t"$22"\t"$23}' > raw.txt-10
less raw.txt-4| awk -F ''  '{for (i=1;i<=NF;i++) printf("%s\t", $i);print ""}'|sed 's/\t$//g' > raw.txt-10
less raw.txt-3|awk -F '\t' '{print "seed""\t""raw.txt_Seq_"NR"\t"$2"\t"$2+19"\t"$6}' > raw.txt-9
paste raw.txt-10 raw.txt-9  |grep -v '-' > raw.txt-11

# less ./sgRNA/raw.txt-rank.fa |grep -v '>'|awk -F '' '{print $1"\t"$2"\t"$3"\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9"\t"$10"\t"$11"\t"$12"\t"$13"\t"$14"\t"$15"\t"$16"\t"$17"\t"$18"\t"$19"\t"$20"\t"$21"\t"$22"\t"$23}' > raw.txt-rank.fa.2
less ./sgRNA/raw.txt-rank.fa  |grep -v '>'|awk -F ''  '{for (i=1;i<=NF;i++) printf("%s\t", $i);print ""}'|sed 's/\t$//g' > raw.txt-rank.fa.2

for i in `seq 1 $length_rank`; do awk '{if ($'$i'== "A") print $'$i'"\t""'$i'"}' raw.txt-rank.fa.2;done > raw.txt-A-location
for i in `seq 1 $length_rank`; do awk '{if ($'$i'== "C") print $'$i'"\t""'$i'"}' raw.txt-rank.fa.2;done > raw.txt-C-location
for i in `seq 1 $length_rank`; do awk '{if ($'$i'== "G") print $'$i'"\t""'$i'"}' raw.txt-rank.fa.2;done > raw.txt-G-location
for i in `seq 1 $length_rank`; do awk '{if ($'$i'== "T") print $'$i'"\t""'$i'"}' raw.txt-rank.fa.2;done > raw.txt-T-location

for i in `less raw.txt-A-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "A") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""AA"}';done > raw.txt-AA
for i in `less raw.txt-A-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "G") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""AG"}';done > raw.txt-AG
for i in `less raw.txt-A-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "C") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""AC"}';done > raw.txt-AC
for i in `less raw.txt-A-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "T") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""AT"}';done > raw.txt-AT
cat raw.txt-AA raw.txt-AG raw.txt-AC raw.txt-AT > raw.txt-A-location-summary

for i in `less raw.txt-C-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "C") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""CC"}';done > raw.txt-CC
for i in `less raw.txt-C-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "T") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""CT"}';done > raw.txt-CT
for i in `less raw.txt-C-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "G") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""CG"}';done > raw.txt-CG
for i in `less raw.txt-C-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "A") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""CA"}';done > raw.txt-CA
cat raw.txt-CC raw.txt-CT raw.txt-CG raw.txt-CA > raw.txt-C-location-summary

for i in `less raw.txt-G-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "C") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""GC"}';done > raw.txt-GC
for i in `less raw.txt-G-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "T") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""GT"}';done > raw.txt-GT
for i in `less raw.txt-G-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "G") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""GG"}';done > raw.txt-GG
for i in `less raw.txt-G-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "A") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""GA"}';done > raw.txt-GA
cat raw.txt-GC raw.txt-GT raw.txt-GG raw.txt-GA > raw.txt-G-location-summary

for i in `less raw.txt-T-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "C") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""TC"}';done > raw.txt-TC
for i in `less raw.txt-T-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "T") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""TT"}';done > raw.txt-TT
for i in `less raw.txt-T-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "G") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""TG"}';done > raw.txt-TG
for i in `less raw.txt-T-location|awk '{print $2}'`;do less raw.txt-11|awk '{if ($'$i' == "A") print $'$i'"\t""'$i'""\t"$(NF-3)"\t"$(NF-2)"\t"$(NF-1)"\t"$NF"\t""TA"}';done > raw.txt-TA
cat raw.txt-TC raw.txt-TT raw.txt-TG raw.txt-TA > raw.txt-T-location-summary

cat raw.txt-A-location-summary raw.txt-T-location-summary raw.txt-C-location-summary raw.txt-G-location-summary |sort -k3n > raw.txt-location

for i in `seq 1 $length_rank`; do less raw.txt-location|sort -k2n|awk '{if ($2=="'$i'") print $0}' > raw.txt-$i;datamash sum -W 6 < raw.txt-$i|awk '{print $0"\t""'$i'"}' > raw.txt-$i.sum ;rm raw.txt-$i;done
for j in `less list`; do for i in `seq 1 $length_rank`; do less raw.txt-location|sort -k2n|awk '{if(($2=="'$i'")&&($7=="'$j'")) print $0}' > raw.txt-$j.$i;datamash sum -W 6 < raw.txt-$j.$i|awk '{print $0"\t""'$i'""\t""'$j'"}' > raw.txt-$j.$i.sum;done;done
for j in `less list`; do for i in `seq 1 $length_rank`; do rm raw.txt-$j.$i;done;done
find . -name "raw.txt*" -type f -size 0c | xargs -n 1 rm -f
for j in `less list`; do for i in `seq 1 $length_rank`; do paste raw.txt-$j.$i.sum raw.txt-$i.sum |awk '{print 100*$1/$4"%""\t"$2"\t"$3}' ;done;done |sort -k2n > raw.txt-site-efficiency
find . -name "raw.txt*" -type f -size 0c | xargs -n 1 rm -f
for j in `less list`; do for i in `seq 1 $length_rank`; do rm raw.txt-$j.$i;rm raw.txt-$j.$i.sum; rm raw.txt-$i.sum;rm raw.txt-$i.$j.combine;done;done

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-9
rm raw.txt-10
rm raw.txt-11
rm raw.txt-rank.fa.2
rm raw.txt-AA
rm raw.txt-AG
rm raw.txt-AC
rm raw.txt-AT
rm raw.txt-A-location
rm raw.txt-CC
rm raw.txt-CT
rm raw.txt-CG
rm raw.txt-CA
rm raw.txt-C-location
rm raw.txt-GA
rm raw.txt-GG
rm raw.txt-GC
rm raw.txt-GT
rm raw.txt-G-location
rm raw.txt-TA
rm raw.txt-TG
rm raw.txt-TC
rm raw.txt-TT
rm raw.txt-T-location
rm raw.txt-rank.fa.2

rm raw.txt-base-combine-summary
#1. A-G/C-G
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CG'|grep -v 'CA'|grep -v 'CT'> raw.txt-CG

cat raw.txt-CG raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CG"}' >> raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CG"" >> raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#2. A-G/C-T
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep -v 'CA'|grep -v 'CG'> raw.txt-CT

cat raw.txt-AG raw.txt-CT |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CT"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CT"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CT
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#3. A-G/C-A
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CA'|grep -v 'CT'|grep -v 'CG'> raw.txt-CA

cat raw.txt-CA raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CA"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#4. A-G/C-T/C-G
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep 'CG'|grep -v 'CA'> raw.txt-CT_CG

cat raw.txt-AG  raw.txt-CT_CG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CT_CG"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CT_CG"" >> raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CT_CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#5. A-G/C-T/C-A
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep 'CA'|grep -v 'CG'> raw.txt-CT_CA

cat raw.txt-CT_CA raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CT_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CT_CA"" >> raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CT_CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#6. A-G/C-G/C-A
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CG'|grep 'CA'|grep -v 'CT'> raw.txt-CG_CA
   
cat raw.txt-CG_CA raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CG_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CG_CA"" >>  raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CG_CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#7. A-G/C-G/C-T/C-A
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CG'|grep 'CT'|grep 'CA'> raw.txt-CG_CT_CA
   
cat raw.txt-CG_CT_CA raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG_CG_CT_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG_CG_CT_CA"" >> raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CG_CT_CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#8. A-G
less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
less raw.txt-6|grep 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AG

if [ -s raw.txt-C-location-summary ] ; then 
   less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
   for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
   for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
   paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
   less raw.txt-3|grep 'CC'|grep -v 'CG'|grep -v 'CT'|grep -v 'CA'> raw.txt-CC
else
  cp raw.txt-AG raw.txt-CC
fi
  
cat raw.txt-CC raw.txt-AG |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_AG"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_AG"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AG
rm raw.txt-CC
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG


#9. C-T
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep -v 'CA'|grep -v 'CG' > raw.txt-CT
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CT raw.txt-AA
fi

cat raw.txt-CT raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CT"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CT"" >>  raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CT
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#10. C-G
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CG'|grep -v 'CT'|grep -v 'CA' > raw.txt-CG
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CG raw.txt-AA
fi
   
cat raw.txt-CG raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CG"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CG"" >>  raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#11. C-A
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CA'|grep -v 'CT'|grep -v 'CG' > raw.txt-CA
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CA raw.txt-AA
fi

cat raw.txt-CA raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CA"" >>  raw.txt-base-combine-summary
fi

rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG


#12. C-T/C-A
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep  'CA'|grep -v 'CG' > raw.txt-CT_CA
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CT_CA raw.txt-AA
fi
   
cat raw.txt-CT_CA raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CT_CA"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CT_CA"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CT_CA
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#13. C-T/C-G
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CT'|grep  'CG'|grep -v 'CA' > raw.txt-CT_CG
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CT_CG raw.txt-AA
fi
   
cat raw.txt-CT_CG raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CT_CG"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CT_CG"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CT_CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#14. C-A/C-G
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CA'|grep  'CG'|grep -v 'CT' > raw.txt-CA_CG
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CA_CG raw.txt-AA
fi

cat raw.txt-CA_CG raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CA_CG"}' >> raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CA_CG"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CA_CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

#15. C-T/C-A/C-G
less  raw.txt-C-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq >  raw.txt-1
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-2
for i in `less raw.txt-1`; do grep -w $i raw.txt-C-location-summary|awk '{print $6}'|uniq;done > raw.txt-count-C
paste raw.txt-1 raw.txt-2 raw.txt-count-C > raw.txt-3
less raw.txt-3|grep 'CA'|grep  'CG'|grep  'CT' > raw.txt-CT_CA_CG
 
if [ -s raw.txt-A-location-summary ] ; then 
   less  raw.txt-A-location-summary|awk '{print $3"\t"$2"-"$7}' |awk '{print $1}'|sort|uniq > raw.txt-4
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $2"-"$7}'|sort|awk '{for(i=1;i<=NF;i=i+1){a[NR,i]=$i}}END{for(j=1;j<=NF;j++){str=a[1,j];for(i=2;i<=NR;i++){str=str " " a[i,j]}print str}}';done >raw.txt-5
   for i in `less raw.txt-4`; do grep -w $i raw.txt-A-location-summary|awk '{print $6}'|uniq;done >raw.txt-count-A
   paste raw.txt-4 raw.txt-5 raw.txt-count-A > raw.txt-6
   less raw.txt-6|grep 'AA'|grep -v 'AG'|grep -v 'AC'|grep -v 'AT' >raw.txt-AA
else
  cp raw.txt-CT_CA_CG raw.txt-AA
fi

cat raw.txt-CT_CA_CG raw.txt-AA |awk '{print $1}'|sort|uniq -c|awk '{if ($1==2) print $2}'  > raw.txt-7
for i in `less raw.txt-7`; do grep -w $i raw.txt-C-location-summary;done|awk '{print $3"\t"$6}'|sort|uniq >raw.txt-8
if [ -s raw.txt-8 ] ; then 
  datamash sum -W 2 < raw.txt-8|awk '{print 100*$0/total-count"%""\t""raw.txt_CT_CA_CG"}' >>  raw.txt-base-combine-summary
else
  echo ""0" "raw.txt_CT_CA_CG"" >>  raw.txt-base-combine-summary
fi
rm raw.txt-1
rm raw.txt-2
rm raw.txt-3
rm raw.txt-4
rm raw.txt-5
rm raw.txt-6
rm raw.txt-7
rm raw.txt-8
rm raw.txt-count-A
rm raw.txt-count-C
rm raw.txt-AA
rm raw.txt-CT_CA_CG
rm raw.txt-count-T
rm raw.txt-TT
rm raw.txt-count-G
rm raw.txt-GG

rm raw.txt-A-location-summary
rm raw.txt-C-location-summary
rm raw.txt-G-location-summary
rm raw.txt-T-location-summary

