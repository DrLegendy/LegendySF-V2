#!/usr/local/bin/bash

clear

echo ""
echo "Select locale for Names export"
echo ""

DBName=""
CharSet="utf8"

select locale in "common" "exit"
do
	case $locale in
		common)
			CharSet="latin1"	;	break	;;

		*) exit 0
	esac
done

clear

echo ""
echo "Which table do you want to export from $DBName"
echo ""

select table in "item_proto" "mob_proto" "exit"
do
	case $table in
		item_proto)
			php .worker/script/table2names.php $locale $table $CharSet > data/$locale/item_names.txt ; exit 0 ;;
		mob_proto)
			php .worker/script/table2names.php $locale $table $CharSet > data/$locale/mob_names.txt ; exit 0 ;;

		*) exit 0
	esac
done

