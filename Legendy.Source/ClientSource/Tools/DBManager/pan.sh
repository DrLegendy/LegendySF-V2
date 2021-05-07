#!/usr/local/bin/bash

source .worker/lib/utilities.bash

echo ""
echo "What do you want to do?"
echo ""

select type in ".txt to db" "db to .sql" "db to .txt" "exit"
do
	case $type in
		".txt to db")
			echo "Which locale?"
			select_locale
			php .worker/script/excel2item_proto.php $locale $char_set data/$locale/item_proto.txt;
			php .worker/script/excel2mob_proto.php $locale $char_set data/$locale/mob_proto.txt;
			php .worker/script/name2item_proto.php $locale $char_set $name_column_name data/$locale/item_names.txt;
			php .worker/script/name2mob_proto.php $locale $char_set $name_column_name data/$locale/mob_names.txt;
			exit 0
		;;
		"db to .sql")
			echo "Not added yet"
		;;
		"db to .txt")
			echo "Which locale?"
			select_locale
			php .worker/script/item_proto2excel.php $locale $char_set > data/$locale/item_proto.txt
			php .worker/script/mob_proto2excel.php $locale $char_set > data/$locale/mob_proto.txt
			php .worker/script/table2names.php $locale item_proto $char_set > data/$locale/item_names.txt
			php .worker/script/table2names.php $locale mob_proto $char_set > data/$locale/mob_names.txt
			exit 0
		;;
		*) exit 0
	esac
done





