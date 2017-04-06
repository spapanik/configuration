manage_local() {python manage.py ${@} --settings=settings.local}
manage_test() {python manage.py ${@} --settings=settings.test}
pb () { curl -F "c=@${1:--}" https://ptpb.pw/ }
gcg () {
    MATCHES=( $(git branch --no-color | cut -c 3- | grep $@) )
    case ${#MATCHES[@]} in
        0) echo "No branches matched '$@'";;
        1) git checkout ${MATCHES[1]};;
        *) echo "More than one branches matched '$@'";;
    esac
}
