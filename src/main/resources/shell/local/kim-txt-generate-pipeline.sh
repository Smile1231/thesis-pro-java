fastq-join  ./raw_fastq/fastq_id.R1.fq.gz ./raw_fastq/fastq_id.R2.fq.gz -o fastq_id.fastq
rm fastq_id.fastqun1
rm fastq_id.fastqun2

var=full_sequence
# echo ${var:0:15} |awk '{print ">header""\n"$0}' > fastq_id_header
# echo ${var:0-15} |awk '{print ">tailer""\n"$0}' >fastq_id_tailer
# cat fastq_id_header fastq_id_tailer > fastq_id_indicator.fa 
# rm fastq_id_tailer
# rm fastq_id_header
fastq_id_header=`echo ${var:0:15} |awk '{print $0}'`
fastq_id_tailer=`echo ${var:0-15} |awk '{print $0}'`

# java -jar /media/Extend_2/lilab/software/Trimmomatic-0.39/trimmomatic-0.39.jar SE -phred33 \
# fastq_id.fastqjoin \
# out.fastq_id.fastqjoin \
# ILLUMINACLIP:/media/Extend_2/lilab/kim/indicator.fa:1:30:10 \
# SLIDINGWINDOW:5:20 \
# LEADING:5 \
# TRAILING:5 \
# MINLEN:100

# 3. reverse complementary, for  the convenience of needle pairwise alignment.
less fastq_id.fastqjoin|awk '{if (NR%4==2) print ">fastq_id_"NR"\n"$0}' > fastq_id.join.fa 
blat -stepSize=5 -repMatch=2147483647 -minScore=20 -minIdentity=0 fastq_id.join.fa rank.fa fastq_id.psl
less fastq_id.psl|grep 'fastq_id'|awk -F '\t' '{if (($1>100)&&($9=="+")) print $14}'|sort|uniq  > fastq_id_positive
seqkit grep -f fastq_id_positive fastq_id.join.fa > fastq_id_positive.fa
less fastq_id.psl|grep 'fastq_id'|awk  -F '\t' '{if (($1>100)&&($9=="-")) print $14}'|sort|uniq  > fastq_id_negative
seqkit grep -f fastq_id_negative fastq_id.join.fa > fastq_id_negative.fa
seqkit seq fastq_id_negative.fa -r -p --seq-type DNA > fastq_id_temp.fa 
cp fastq_id_temp.fa fastq_id_negative.fa
cat fastq_id_positive.fa fastq_id_negative.fa > fastq_id_rectify.fa

seqkit seq  fastq_id_rectify.fa -w 0 >  fastq_id_1.fa 

less  fastq_id_1.fa|grep $fastq_id_header|grep $fastq_id_tailer |sed -r 's/.*'$fastq_id_header'(.*)'$fastq_id_tailer'.*/\1/' |awk '{print "'$fastq_id_header'"$1"'$fastq_id_tailer'"}'  > fastq_id_rectify_with_both_indicator.fa 

seqkit seq  rank.fa -w 0|grep $fastq_id_header|grep $fastq_id_tailer|sed -r 's/.*'$fastq_id_header'(.*)'$fastq_id_tailer'.*/\1/'|awk '{print "'$fastq_id_header'"$1"'$fastq_id_tailer'"}'  >  fastq_id_rank_cut.fa

less fastq_id_rectify_with_both_indicator.fa|sort|uniq -c |awk '{if ($1 >1)  print $0}' > fastq_id_count
less fastq_id_count|awk '{print "fastq_id_"NR"\t"$1"\t"$2}' |sort -k2nr > fastq_id_count_valid
less fastq_id_count|awk '{print ">fastq_id_"NR"\n"$2}' > fastq_id_valid.fa 

needleall -asequence   fastq_id_rank_cut.fa -bsequence  fastq_id_valid.fa  -awidth 500 -auto -aformat fasta -outfile fastq_id_1.fasta.alignment
seqkit seq fastq_id_1.fasta.alignment -w 0 > fastq_id_1.fasta.alignment.1
less fastq_id_1.fasta.alignment.1|awk '{if (NR%4==1) print $0}' |sed 's/>//g' > fastq_id_WT_id 
less fastq_id_1.fasta.alignment.1|awk '{if (NR%4==2) print $0}' > fastq_id_WT_seq
less fastq_id_1.fasta.alignment.1|awk '{if (NR%4==3) print $0}' |sed 's/>//g' > fastq_id_illumina_id
less fastq_id_1.fasta.alignment.1|awk '{if (NR%4==0) print $0}' > fastq_id_illumina_seq  
for i in 	`less fastq_id_illumina_id`;do grep -w $i  fastq_id_count_valid|awk '{print $1"\t"$2}';done > fastq_id_illumina_id_count
paste  fastq_id_WT_seq fastq_id_WT_id  fastq_id_illumina_seq fastq_id_illumina_id_count |awk '{print $1"\t"$2"\t"$3"\t"$5"\t"$4}' |sort -k4nr> fastq_id.txt

rm fastq_id.join.fa 
rm fastq_id.psl
rm fastq_id_positive
rm fastq_id_positive.fa
rm fastq_id_negative
rm fastq_id_negative.fa
rm fastq_id_temp.fa 
rm fastq_id_rectify.fa
rm fastq_id_1.fa 
rm fastq_id_rectify_with_both_indicator.fa 
rm   fastq_id_rank_cut.fa
rm  fastq_id_count
rm  fastq_id_count_valid
rm  fastq_id_valid.fa 
rm  fastq_id_1.fasta.alignment
rm  fastq_id_1.fasta.alignment.1
rm fastq_id_WT_id 
rm fastq_id_WT_seq
rm fastq_id_illumina_id
rm fastq_id_illumina_seq  
rm fastq_id_illumina_id_count
rm needleall.error

unset $var
unset $fastq_id_header
unset $fastq_id_tailer
rm fastq_id.fastqjoin






