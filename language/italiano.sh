#/bin/sh

#pacchetto lingua per il menu di dialogo

#Generic
NOTIMPLEMENTED="Ancora non implementato"
INSTALLPACKAGES="Installazione "

#start.sh
TITLE="script di costruzione e avvio di osu!lazer"
WINDOW="Menu"
RUN="Avvia osu!lazer"
COMPILE="Clona e Compila osu!lazer"
PKG="Crea un eseguibile linux(non obbligatorio)"
DEPENDS="Installa Dipendenze"
CHOOSE="Scegli una delle seguenti opzioni:"
QUICKFIXES="QuickFixes"
QUICKFIXES2="Quickfixes per problemi risaputi"
DELFRAMEWORKINI="Rimuovi framework.ini, ripara il mancato avvio"
NOOSUFOUND="non è stato trovato osulazer, inizia prima la compilazione"
OLDOSUFOUND="vecchio osulazer trovato"
BUILDNEWASK="Vuoi cancellare la vecchia versione per costruirne una più recente"
SURETODELETE="Sei sicuro di voler cancellare la tua vecchia cartella e build di osu ( ha bisogno di root) "
OSUNOTREMOVED="osu invariato"
ESCPRESSED="[ESC] Schiacciato"

#Quickfixes.sh
NOTHINGHERE="Per adesso, vuoto"
DELFRAMEWORKINI="Rimuovi framework.ini, ripara il mancato avvio"
DELFRAMEWORKINI2="Rimuovendo framework.ini da ~/.local/share/osu"

APPIMG_DOWNLOAD_DIALOG="Download osu!lazer AppImage"
APPIMG_NEWEST_ALREADY_DOWNLOADED="La versione più recente è già stata scaricata"
APPIMG_GITHUB_API_LIMIT="Il limite di richieste alle API di GitHub è stato raggiunto, riprova tra qualche minuto"
APPIMG_ALREADY_DOWNLOADED="Questa versione è già stata scaricata"
APPIMG_UPDATE_AVAILABLE="Nuova AppImage disponibile, vai su AppImage/Download per aggiornare"
APPIMG_CHMOD_1="La AppImage di osu!lazer deve essere impostata come eseguibile"
APPIMG_CHMOD_2="Eseguiremo sudo chmod +x $path2, se non ti fidi di questo script puoi farlo tu stesso"
APPIMG_CHMOD_3="Premi invio quando sei pronto"
APPIMG_CHMOD_ERROR="Errore: AppImage non è un eseguibile"
