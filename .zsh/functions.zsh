manage_local() {python manage.py ${@} --settings=settings.local} 
manage_test() {python manage.py ${@} --settings=settings.test} 
pb () { curl -F "c=@${1:--}" https://ptpb.pw/ }
glb () {
    git branch -vv --no-color | grep --color=never ] | awk '{print substr($0,3);}' | awk '{$2=""; print $0}'| awk -F']' '{print $1}'| awk -F':|\\[' '{$2=""; if ($3=="") print $0; else print $1,"\033[1;31m"$3"\033[0m ";}' && git branch -vv --no-color | grep --color=never -v ] | awk '{print substr($0,3);}' | awk '{print $1,"\033[1;31mlocal only\033[0m "}'
}
