# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public at gmail.com>

pkgname=<+$BASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
arch=('i686' 'x86_64')
#arch=('any')
url='https://sourceforge.net/projects/<+$BASENAME$+>'
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
noextract=()
source=(https://downloads.sourceforge.net/project/$pkgname/$pkgname-$pkgver.tar.gz)
sha512sums=()

build(){
  cd "$srcdir"/$pkgname-$pkgver

  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$pkgname-$pkgver

  make DESTDIR="$pkgdir/" install
}

