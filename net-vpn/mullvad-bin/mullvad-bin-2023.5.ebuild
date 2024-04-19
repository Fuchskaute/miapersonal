EAPI=8

inherit desktop unpacker xdg-utils

MY_PN="Mullvad VPN"

DESCRIPTION="Mullvad VPN Client"
HOMEPAGE="https://mullvad.net"
SRC_URI="https://github.com/mullvad/mullvadvpn-app/releases/download/${PV}/MullvadVPN-${PV}_amd64.deb"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

PYTHON_COMPAT=( python3_{6..12} )

IUSE="systemd"

RDEPEND="
	net-print/cups
	dev-libs/nss
	sys-apps/dbus
	x11-libs/libnotify
	dev-libs/libappindicator
"

src_install() {
	insinto /opt
	doins -r opt/'Mullvad VPN'
	insinto /usr
	doins -r usr/bin
	doins -r usr/lib
	doins -r usr/local
	doins -r usr/share
	fperms 755 /opt/Mullvad\ VPN/mullvad-vpn
	fperms 755 /usr/bin/mullvad-daemon
	fperms 755 /opt/Mullvad\ VPN/mullvad-gui
	fperms 4755 /opt/Mullvad\ VPN/chrome-sandbox

	domenu usr/share/applications/mullvad-vpn.desktop

	local x
	for x in 16 32 64 128 256 512; do
		doicon -s ${x} usr/share/icons/hicolor/${x}*/*
	done

	if use systemd ; then
		systemd_dounit "${FILESDIR}"/mullvad-daemon.service
		elog "Please make sure to enable the mullvad-daemon service"
	else
		newinitd "${FILESDIR}/mullvad-daemon.initd" mullvad-daemon
		elog "Please make sure to enable the mullvad-daemon service"
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
