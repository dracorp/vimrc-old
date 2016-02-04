# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public@gmail.com>

pkgname=perl-<+$LBASENAME$+>
pkgver=<+#VERSION#+>
pkgrel=1
_author="<+#AUTHOR_NAME#+>"
_perlmod="<+$BASENAME$+>"
pkgdesc="<+$BASENAME$+> - <+#DESCRIPTION#+>"
arch=('any')
url="http://search.cpan.org/dist/<+$BASENAME$+>/"
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
source=("http://search.cpan.org/CPAN/authors/id/$_author/$_perlmod-$pkgver.tar.gz")

build(){
  cd "$srcdir"/$_perlmod-$pkgver
  unset PERL5LIB PERL_MM_OPT PERL_MB_OPT PERL_LOCAL_LIB_ROOT
  export PERL_MM_USE_DEFAULT=1 PERL_AUTOINSTALL=--skipdeps MODULEBUILDRC=/dev/null

  # If using Makefile.PL
  /usr/bin/perl Makefile.PL
  make

  # If using Build.PL
  /usr/bin/perl Build.PL
  ./Build
}
check(){
  cd "$srcdir"/$_perlmod-$pkgver

  unset PERL5LIB PERL_MM_OPT PERL_MB_OPT PERL_LOCAL_LIB_ROOT
  export PERL_MM_USE_DEFAULT=1
  # If using Makefile.PL
  make test
  # If using Build.PL
  ./Build test
}
package(){
  cd "$srcdir"/$_perlmod-$pkgver

  unset PERL5LIB PERL_MM_OPT PERL_MB_OPT PERL_LOCAL_LIB_ROOT
  # If using Makefile.PL
  make install INSTALLDIRS=vendor DESTDIR="$pkgdir"
  # If using Build.PL
  ./Build install installdirs=vendor destdir="$pkgdir"

  # remove perllocal.pod and .packlist
  #find "$pkgdir" -name .packlist -o -name perllocal.pod -delete
}
