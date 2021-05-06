#percorso relativo
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

#seleziona tipo di monitoraggio
monitoraggio="full"

cd $DIR

#eseguo il programma
programma="./index_$monitoraggio.sh"
$programma
