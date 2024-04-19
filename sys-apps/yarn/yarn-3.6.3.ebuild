# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast, reliable, and secure node dependency management"
HOMEPAGE="https://yarnpkg.com"
SRC_URI="https://github.com/yarnpkg/berry/archive/refs/tags/@yarnpkg/cli/${PV}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~x86"
IUSE=""

RDEPEND="!dev-util/cmdtest
	net-libs/nodejs"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	sed -i 's/"installationMethod": "tar"/"installationMethod": "portage"/g' "${S}/package.json" || die
}

src_install() {
	local install_dir="/usr/$(get_libdir)/node_modules/yarn" path shebang
	insinto "${install_dir}"
	doins -r .
	dosym "../$(get_libdir)/node_modules/yarn/bin/yarn.js" "/usr/bin/yarn"
	dosym "../$(get_libdir)/node_modules/yarn/bin/yarnpkg" "/usr/bin/yarnpkg"

	while read -r -d '' path; do
		read -r shebang < "${ED}${path}" || die
		[[ "${shebang}" == \#\!* ]] || continue
		fperms +x "${path}"
	done < <(find "${ED}" -type f -printf '/%P\0' || die)
}
