# Copyright 2017-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
	adaptor-0.1.0
	addr2line-0.21.0
	adler-1.0.2
	aho-corasick-1.1.1
	android-tzdata-0.1.1
	android_system_properties-0.1.5
	ansi-to-tui-3.1.0
	anstream-0.6.4
	anstyle-1.0.4
	anstyle-parse-0.2.2
	anstyle-query-1.0.0
	anstyle-wincon-3.0.1
	anyhow-1.0.75
	app-0.1.0
	async-channel-1.9.0
	autocfg-1.1.0
	backtrace-0.3.69
	base64-0.21.4
"

PYTHON_COMPAT=( python3_{9..12} )

inherit cargo

DESCRIPTION=" Blazing fast terminal file manager written in Rust, based on async I/O."
HOMEPAGE="https://github.com/sxyazi/yazi"

if [ ${PV} == "9999" ] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/sxyazi/yazi"
else
	SRC_URI="https://github.com/sxyazi/yazi/archive/refs/tags/v${PV}.tar.gz" -> ${PV}.tar.gz
		$(cargo_crate_uris)
