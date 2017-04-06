manage_local() {python manage.py ${@} --settings=settings.local}
manage_test() {python manage.py ${@} --settings=settings.test}
pb () { curl -F "c=@${1:--}" https://ptpb.pw/ }
