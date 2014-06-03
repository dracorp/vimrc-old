# vim:set ts=2 sw=2 et ft=sh tw=100: expandtab
# Maintainer: Piotr Rogoża <piotr dot r dot public at gmail dot com>
# Contributor: Piotr Rogoża <piotr dot r dot public at gmail dot com>

pkgname=<+$BASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
arch=('i686' 'x86_64')
#arch=('any')
url='<+#URL#+>'
license=('GPL')
groups=()
depends=()
makedepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=''
source=("$pkgname-$pkgver.tar.gz::<+#URLDOWNLOAD#+>")
noextract=()

build(){
  cd "$srcdir"/$pkgname-$pkgver

  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$pkgname-$pkgver

  make DESTDIR="$pkgdir/" install
}
