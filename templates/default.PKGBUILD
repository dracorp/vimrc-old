# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public at gmail.com>

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
