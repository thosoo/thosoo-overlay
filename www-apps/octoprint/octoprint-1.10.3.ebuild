# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Modern PEP‑517 build via setuptools; install for the default Python only.
DISTUTILS_USE_PEP517="setuptools"
DISTUTILS_SINGLE_IMPL=1

PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

MY_PN="OctoPrint"

###
# OctoPrint 1.10.3 is the last release whose requirements are *mostly* in the
# main Gentoo tree, so this ebuild keeps the overlay footprint to a minimum.
###

DESCRIPTION="Snappy web interface for your 3D printer"
HOMEPAGE="https://octoprint.org/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"

IUSE="plugins develop"

# -----------------------------------------------------------------------------
# Overlay‑only deps (missing from ::gentoo at time of writing)
# -----------------------------------------------------------------------------
OVERLAY_RDEPEND="
    >=dev-python/flask-assets-2.1.0 <dev-python/flask-assets-3
    >=dev-python/flask-limiter-3.8 <dev-python/flask-limiter-3.9
    dev-python/cookiecutter   # pulled by +plugins
"

# -----------------------------------------------------------------------------
# Main runtime deps (all present in ::gentoo)
# Versions follow upstream pin range from setup.py 1.10.3.
# -----------------------------------------------------------------------------
RDEPEND="
    acct-user/octoprint
    acct-group/octoprint

    dev-python/argon2-cffi
    >=dev-python/babel-2.9 <dev-python/babel-2.11
    >=dev-python/cachelib-0.9 <dev-python/cachelib-0.14
    >=dev-python/click-8.1.3 <dev-python/click-9
    >=dev-python/colorlog-6.7 <dev-python/colorlog-7
    >=dev-python/emoji-2.1 <dev-python/emoji-3
    >=dev-python/feedparser-6.0.8 <dev-python/feedparser-7
    >=dev-python/filetype-1.1 <dev-python/filetype-2
    >=dev-python/flask-2.2 <dev-python/flask-3
    >=dev-python/flask-babel-3.0 <dev-python/flask-babel-5
    >=dev-python/flask-login-0.6 <dev-python/flask-login-0.7
    >=dev-python/frozendict-2.3 <dev-python/frozendict-3
    >=dev-python/markdown-3.4 <dev-python/markdown-3.8
    >=dev-python/netaddr-0.8 <dev-python/netaddr-1.4
    >=dev-python/netifaces-0.11 <dev-python/netifaces-0.12
    dev-python/packaging
    >=dev-python/libpass-1.7 <dev-python/libpass-2
    >=dev-python/pathvalidate-2.5 <dev-python/pathvalidate-4
    >=dev-python/psutil-5.9 <dev-python/psutil-7
    >=dev-python/pydantic-1.10 <dev-python/pydantic-3
    >=dev-python/pylru-1.2 <dev-python/pylru-2
    >=dev-python/pyserial-3.5 <dev-python/pyserial-4
    dev-python/pytz
    >=dev-python/pyyaml-6 <dev-python/pyyaml-7
    >=dev-python/requests-2.28 <dev-python/requests-3
    =dev-python/sarge-0.1.7_p1-r0
    >=dev-python/semantic-version-2.10 <dev-python/semantic-version-3
    >=dev-python/sentry-sdk-1.5 <dev-python/sentry-sdk-3
    dev-python/setuptools
    >=dev-python/tornado-6.2 <dev-python/tornado-6.5
    >=dev-python/watchdog-3 <dev-python/watchdog-5
    >=dev-python/websocket-client-1.4 <dev-python/websocket-client-1.9
    >=dev-python/werkzeug-2.2 <dev-python/werkzeug-3.1
    >=dev-python/wrapt-1.14 <dev-python/wrapt-1.18
    >=dev-python/zeroconf-0.38 <dev-python/zeroconf-0.137
    >=dev-python/zipstream-ng-1.5 <dev-python/zipstream-ng-2

    dev-python/regex
    dev-python/unidecode

    plugins? ( dev-python/cookiecutter )
"

# No build‑time deps needed outside the overlay extras.

distutils_enable_tests pytest
