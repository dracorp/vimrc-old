# vim:set ts=2 sw=2 et ft=sh tw=100: expandtab
# Maintainer: Piotr Rogoża <piotr dot r dot public at gmail dot com>
# Contributor: Piotr Rogoża <piotr dot r dot public at gmail dot com>

pkgname=<+$BASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
arch=('i686' 'x86_64')
url='<+#URL#+>'
license=('GPL')
groups=()
depends=()
makedepends=(git)
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
noextract=()
source=('<+#GITROOT#+>')
_gitname='<+#GITNAME#+>'
md5sums=(SKIP)

#pkgver() {
#  if [ -d "$srcdir"/$_gitname ]; then
#    cd "$srcdir"/$_gitname
#    git describe --always | sed 's|-|.|g'
#  fi
#}
build(){
  cd "$srcdir"
#  msg2 "Connecting to GIT server...."

#  if [ -d ${_gitname}/.git ] ; then
#    cd $_gitname
#    git pull --depth 1 origin
#    msg2 "The local files are updated."
#  else
#    git clone --depth 1 $_gitroot $_gitname
#    cd $_gitname
#  fi

#  msg2 "GIT checkout done or server timeout"
  msg2 "Starting make"

  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$_gitname
  msg2 "Starting make install"
  make DESTDIR="$pkgdir/" install
}
