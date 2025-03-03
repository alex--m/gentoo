# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DIST_AUTHOR=YVES
DIST_VERSION=4.023
inherit edo perl-module toolchain-funcs

DESCRIPTION="Fast, compact, powerful binary deserialization"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	virtual/perl-XSLoader
	app-arch/csnappy:=
	app-arch/zstd:=
	>=dev-libs/miniz-2.2.0-r1:=
"
DEPEND="
	app-arch/csnappy:=
	app-arch/zstd:=
	>=dev-libs/miniz-2.2.0-r1:=
"
BDEPEND="${RDEPEND}
	dev-perl/Devel-CheckLib
	>=virtual/perl-ExtUtils-MakeMaker-7.0
	>=virtual/perl-ExtUtils-ParseXS-2.210.0
	virtual/perl-File-Path
	virtual/pkgconfig
	test? (
		virtual/perl-Data-Dumper
		virtual/perl-File-Spec
		virtual/perl-Scalar-List-Utils
		dev-perl/Test-Deep
		dev-perl/Test-Differences
		dev-perl/Test-LongString
		>=virtual/perl-Test-Simple-0.880.0
		dev-perl/Test-Warn
	)
"

src_prepare() {
	local bundled_lib
	for bundled_lib in inc/Devel snappy miniz{.c,.h} zstd ; do
		edo rm -r ${bundled_lib}
	done

	sed -i -e "/miniz.*OBJ_EXT/d" inc/Sereal/BuildTools.pm || die

	perl-module_src_prepare
}

src_compile() {
	DIST_MAKE=(
		  "INC=$($(tc-getPKG_CONFIG) --cflags miniz)"
		  "OTHERLDFLAGS=$($(tc-getPKG_CONFIG) --libs miniz)"
	)

	perl-module_src_compile
}
