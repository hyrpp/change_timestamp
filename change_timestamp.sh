#!bin/bash

# 写真の更新日時を撮影日時に合わせるスクリプト。
# ファイル名の形式を入力するようにすることで、無音カメラ以外で撮影した写真にも対応。
# touch -t YYYYMMDDhhmm.ss [ファイル名] のコマンドでタイムスタンプを変更できる。

#dir: 画像ファイルの入ったディレクトリの相対パス(入力)
#dirfile: ディレクトリ内のjpegファイル(沢山)
#filepass: dirfileのうち1つ。jpegファイルの相対パス。
#file: jpegファイルの拡張子部分を落としたファイル名。
#day; YYYYMMDD
#hm: hhmm
#sec: ss
#time: YYYYMMDDhhmm.ss

# ディレクトリのパスを入力
echo "input directory pass: "
read dir

# ファイルの形式を入力
echo "input file type(ex. YYYYMMDD_hhmmss_xxx.jpg, screenshot_YYYYDDMM_hhmmss.png): "
read file_tipe

echo -----

# 年月日がファイル名のどの位置にあるのか検索
bef_Y=${file_tipe%YYYY*}
pos_Y=${#bef_Y}
bef_M=${file_tipe%MM*}
pos_M=${#bef_M}
bef_D=${file_tipe%DD*}
pos_D=${#bef_D}
bef_h=${file_tipe%hh*}
pos_h=${#bef_h}
bef_m=${file_tipe%mm*}
pos_m=${#bef_m}
bef_s=${file_tipe%ss*}
pos_s=${#bef_s}

ext=${file_tipe#*.} # 拡張子（"."を含まない）

dirfile=$dir/*.$ext
for filepass in $dirfile
do
	file=${filepass##*/}
	day=${file:pos_Y:4}${file:pos_M:2}${file:pos_D:2}
	hm=${file:pos_h:2}${file:pos_m:2}
	sec=${file:pos_s:2}

#	echo 'file:' $file
#	echo 'day,hm,sec:'$day, $hm, $sec

	time=${day}${hm}.${sec}
#	echo $time
	
	touch -t $time $filepass
done

echo "completed!!!"
