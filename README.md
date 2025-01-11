# Calibre-Appimage
a calibre appimage with entry of ebook-editor those

it use like other appimage of calibre but create entry of book editor and using AppRun from https://gist.github.com/iTrooz/f287a48b95d672c3c97fea4f12a40891 which allow it to exec all binaray included

you can use --lsexec to show what binary included and --exec to specifically use one of them ```PATH_TO_APPIMAGE --lsexec``` ```PATH_TO_APPIMAGE --exec ebook-editor```

# How to use
1) using ```git clone https://github.com/miullu/Calibre-Appimage```
2) ```cd Calibre-Appimage & sh appimagecreate.sh $path_of_appimage_place```
3) Done!

Well actually sometime you can just download it from release, but it isnt the latest and the entry may need to create by yourself (download *.desktop and edit path by yourself)

# issue i have met
libxkbfile is important
qt isnt required but libxkbfile is

ps: the original qt is supper huge!
