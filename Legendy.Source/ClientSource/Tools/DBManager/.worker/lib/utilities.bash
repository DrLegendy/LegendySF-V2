
select_locale()
{
	select locale in "common" "exit" 
	do
		case $locale in
			common)
				char_set="latin1";
				name_column_name="locale_name";
				break;;
			*) exit 0
		esac
	done
}

