#!/bin/bash
# マネーフォワードのCSVをUTF8に書き出して日付順に並べるコード

# Macかどうかチェックしてから実行
[[ `uname` == Darwin ]] &&
for filename in `ls 収入・支出詳細_*[0-9][0-9].csv`; do
  cat $filename | iconv -f cp932 -t utf8 |
  # 店名とかメモに不要な改行が入っているときに修正（PayPayあるある）
  awk '{if($0~/[^"]$/){c=c""$0}else{print c""$0;c=""}}' |
  # 2行目から日付でsort
  awk 'NR==1;NR>1{print $0|"sort -t, -k2"}' > `echo $filename | sed 's/\.csv//g'`_utf8.csv
done
