# Maintainer: dracorp aka Piotr Rogoza <piotr.r.public at gmail.com>

pkgname=<+$BASENAME$+>
pkgver=<+#VERSION#+>
_scriptid=<+#SRIPT_ID_SRC#+>
pkgrel=1
pkgdesc='<+#DESCRIPTION#+>'
arch=('any')
url='http://vim.org/scripts/script.php?script_id=<+#SCRIPT_ID_URL#+>'
license=('custom:vim')
groups=('vim-plugins')
depends=('vim-runtime')
makedepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install='vimdoc.install'
source=("${pkgname}-${pkgver}.zip::http://www.vim.org/scripts/download_script.php?src_id=${_scriptid}")

package() {
	cd "$srcdir"
	_vim_dir='usr/share/vim/vimfiles'
  vim -c "set nomore" -c "UseVimball $srcdir" -c "q" $pkgname.vba

  install -dm755 ${pkgdir}/${_vim_dir} || return 1

  tar -c ./  --exclude ${pkgname}-${pkgver}.zip | tar -x -C ${pkgdir}/${_vim_dir} || return 1
}
