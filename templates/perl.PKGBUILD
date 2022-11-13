# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public at gmail.com>

pkgname=perl-<+$LBASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
_author="<+#AUTHOR_NAME#+>"
_perlmod="<+$BASENAME$+>"
pkgdesc="<+$BASENAME$+> - <+#DESCRIPTION#+>"
arch=('any')
url="https://metacpan.org/dist/<+$BASENAME$+>/"
license=('GPL' 'PerlArtistic')
depends=(perl)
checkdepends=()
makedepends=()
provides=()
conflicts=()
replaces=()
backup=()
install=
noextract=()
options=(!emptydirs)
source=("https://cpan.metacpan.org/authors/id/$_author/$_perlmod-$pkgver.tar.gz")
sha256sums=()
unset PERL5LIB PERL_MM_OPT PERL_MB_OPT PERL_LOCAL_LIB_ROOT
export PERL_MM_USE_DEFAULT=1 PERL_AUTOINSTALL=--skipdeps MODULEBUILDRC=/dev/null

build(){
  cd "$srcdir"/$_perlmod-$pkgver
  if [ -f Makefile.PL ]; then
    perl Makefile.PL
    make
  else
    perl Build.PL
    ./Build
  fi
}
check(){
  cd "$srcdir"/$_perlmod-$pkgver
  if [ -f Makefile.PL ]; then
    make test
  else
    ./Build test
  fi
}
package(){
  cd "$srcdir"/$_perlmod-$pkgver
  if [ -f Makefile.PL ]; then
    make install INSTALLDIRS=vendor DESTDIR="$pkgdir"
  else
    ./Build install --installdirs=vendor --destdir="$pkgdir"
  fi
}
