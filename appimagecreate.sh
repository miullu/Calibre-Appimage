#/bin/sh

version=$(curl -s https://calibre-ebook.com/download_linux | grep -o -E 'The latest release of calibre is [0-9]+\.[0-9]+\.[0-9]+' | grep -o -E "[0-9]+\.[0-9]+\.[0-9]+")
echo "Calibre version: $version"

mkdir calibre.AppDir

mkdir -p calibre.AppDir/usr/bin

cat > calibre.AppDir/calibre.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Calibre
GenericName=E-book library management
Comment=E-book library management: Convert, view, share, catalogue all your e-books
Exec=calibre %F
Icon=calibre
MimeType=application/x-mobipocket-ebook;application/epub+zip;x-content/ebook-reader
Categories=Office;Graphics;Viewer;
X-GNOME-UsesNotifications=true
Actions=Ebook-editor;Ebook-viewer;LRF-viewer;

[Desktop Action Ebook-editor]
Name=Ebook editor
Exec=ebook-edit %f

[Desktop Action Ebook-viewer]
Name=Ebook viewer
Exec=ebook-viewer %f

[Desktop Action LRF-viewer]
Name=LRF viewer
Exec=lrfviewer %f

EOF

chmod +x calibre.AppDir/calibre.desktop

wget https://gist.githubusercontent.com/iTrooz/f287a48b95d672c3c97fea4f12a40891/raw/0812d4bccdde9dcccd8c86e0f1298c553efaafd8/AppRun
mv AppRun calibre.AppDir/

chmod +x calibre.AppDir/AppRun

curl -o - https://download.calibre-ebook.com/$version/calibre-$version-x86_64.txz | tar -xJf - -C calibre.AppDir/usr/bin/

cp calibre.AppDir/usr/bin/resources/content-server/calibre.png calibre.AppDir/

wget https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage

chmod +x appimagetool-x86_64.AppImage

./appimagetool-x86_64.AppImage calibre.AppDir

mv Calibre-x86_64.AppImage Calibre-$version-x86_64.AppImage

mv Calibre-*.AppImage $1/
echo Add desktop shortcut?
sed -i "s@Calibre-x86_64.AppImage@$1/Calibre-$version-x86_64.AppImage@g" *.desktop

yes | cp *.desktop $HOME/.local/share/applications
read -p "Do you want to continue? (yes/no) " answer

if [ "$answer" == "yes" ]; then
  cp *.desktop $HOME/.local/share/applications
  echo Done! You can use "rm -rf $(pwd)" to remove those unneeded now
elif [ "$answer" == "no" ]; then
  echo Done! Tou can use "rm -rf $(pwd)" to remove those unneeded now
  exit 0
else
  echo "Invalid response. Please enter 'yes' or 'no'."
  exit 1
fi
