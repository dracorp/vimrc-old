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
makedepends=(cvs)
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
noextract=()
_vcsroot='<+#CVSROOT#+>'
_vcsname='<+#CVSNAME#+>'

build(){
  cd "$srcdir"
  if [ -d "${_vcsname}/CVS" ];	then
    msg2 "Starting CVS update ..."
		cd "${_vcsname}"
		cvs -z3 update -d
		msg2 "... updating finished."
	else
		msg2 "Starting CVS checkout ..."
	  cvs -z3 -f -d:pserver:${_vcsroot} co "${_vcsname}"
		msg2 "... checkout finished."
    cd "${_vcsname}"
	fi

	if [ -e "${srcdir}/${_vcsname}-build" ];	then
		rm -rf "${srcdir}/${_vcsname}-build"
	fi

  msg2 "CVS checkout done or server timeout"
  msg2 "Starting make"

  ./configure --prefix=/usr
  make
}
package(){
  cd "$srcdir"/$_vcsname
  msg2 "Starting make install"
  make DESTDIR="$pkgdir/" install

  find "$pkgdir" -type d -name ".svn" -exec rm -rf '{}' +;
}
