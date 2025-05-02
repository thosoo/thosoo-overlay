# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

# see scripts/download_import_cldr.py
CLDR_PV=46.0
DESCRIPTION="Collection of tools for internationalizing Python applications"
HOMEPAGE="
https://babel.pocoo.org/
https://pypi.org/project/babel/
https://github.com/python-babel/babel/
"

SRC_URI="
https://files.pythonhosted.org/packages/source/B/Babel/Babel-${PV}.tar.gz
https://unicode.org/Public/cldr/${CLDR_PV%.*}/cldr-common-${CLDR_PV}.zip
"

# upstream unpack creates “Babel-${PV}” not “babel-${PV}”
S="${WORKDIR}/Babel-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~x64-macos"

# match upstream install_requires=['pytz>=2015.7']
RDEPEND="
    dev-python/pytz[${PYTHON_USEDEP}]
"

# unzip for import_cldr, plus test deps
BDEPEND="
    app-arch/unzip
    ${RDEPEND}
    test? (
        dev-python/freezegun[${PYTHON_USEDEP}]
    )
"

distutils_enable_sphinx docs
distutils_enable_tests pytest

src_prepare() {
    distutils-r1_src_prepare
    rm babel/locale-data/*.dat || die
    rm babel/global.dat       || die
}

python_configure() {
    if [[ ! -f babel/global.dat ]]; then
        "${EPYTHON}" scripts/import_cldr.py "${WORKDIR}"/common || die
    fi
}

python_test() {
    local -x TZ=UTC
    epytest
}
