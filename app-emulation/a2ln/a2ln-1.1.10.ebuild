EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit pypi
SLOT=0
KEYWORDS="~amd64"

SRC_URI="$(pypi_sdist_url "${PN}" "${PV}")"
