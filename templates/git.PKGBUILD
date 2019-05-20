# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public at gmail.com>

pkgname=<+$BASENAME$+>
pkgver=1
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
# arch=('i686' 'x86_64')
# arch=(any)
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
source=("git+$url")
_gitname='<+#GITNAME#+>'
md5sums=(SKIP)

pkgver(){
  if [ -d "$srcdir"/$_gitname ]; then
    cd "$srcdir"/$_gitname
    ( set -o pipefail
    git describe --long 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)" )
  fi
}
build(){
  cd "$srcdir"
  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$_gitname
  make DESTDIR="$pkgdir/" install
}
