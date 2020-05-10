#/bin/sh

#language pack for the dialoge menu

#Generic
NOTIMPLEMENTED="Еще не внедрено"
INSTALLPACKAGES="Устанавливается "

#start.sh
TITLE="Скрипт для сборки и запуска osu!lazer"
WINDOW="Меню"
RUN="Запустить osu!lazer"
COMPILE="Клонировать и собрать osu!lazer"
PKG="Собрать исполняемый файл под Linux (необязательно)"
DEPENDS="Установить зависимости"
CHOOSE="Выберите одну из следующих опций:"
QUICKFIXES="Исправления"
QUICKFIXES2="Исправление распространенных проблем"
NOOSUFOUND="osulazer не найден, сначала соберите его"
OLDOSUFOUND="найдена прошлая установка osulazer"
BUILDNEWASK="Хотите удалить прошлый osulazer для сборки нового?"
SURETODELETE="Вы действительно хотите навсегда удалить предыдущую сборку osu? ( понадобятся права суперпользователя ) "
OSUNOTREMOVED="не удалось удалить osu"
ESCPRESSED="Нажата клавиша [ESC]"

#Quickfixes.sh
NOTHINGHERE="Здесь ничего нет"
DELFRAMEWORKINI="Удалить framework.ini, процесс исправления не запускается"
DELFRAMEWORKINI2="Удаление framework.ini из ~/.local/share/osu"

#AppImage Support
APPIMG_DOWNLOAD_DIALOG="Загрузить osu!lazer AppImage"
APPIMG_NEWEST_ALREADY_DOWNLOADED="Самая актуальная версия уже загружена"
APPIMG_GITHUB_API_LIMIT="Превышен лимит запросов к Github API, подождите несколько минут"
APPIMG_ALREADY_DOWNLOADED="Эта версия уже загружена"
APPIMG_UPDATE_AVAILABLE="Доступен новый образ AppImage, перейдите в AppImage/Download для обновления"
APPIMG_CHMOD_1="osu!lazer AppImage должен быть задан как исполняемый"
APPIMG_CHMOD_2="В этой директории будет выполнена команда sudo chmod +x $path2, если вы не доверяете скрипту - сделайте это сами"
APPIMG_CHMOD_3="Нажмите Enter чтобы продолжить"
APPIMG_CHMOD_ERROR="Ошибка: AppImage не является исполняемым"
