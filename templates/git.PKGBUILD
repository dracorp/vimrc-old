# Maintainer: Piotr Rogoza <piotr dot r dot public at gmail dot com>
# Contributor: Piotr Rogoza <piotr dot r dot public at gmail dot com>

pkgname=<+$BASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
arch=('i686' 'x86_64')
#arch=(any)
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

pkgver(){
  if [ -d "$srcdir"/$_gitname ]; then
    cd "$srcdir"/$_gitname
    git describe --always | sed 's|-|.|g'
  fi
}
build(){
  cd "$srcdir"
  msg2 "Starting make"

  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$_gitname
  msg2 "Starting make install"
  make DESTDIR="$pkgdir/" install
}
