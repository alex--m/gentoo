# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

# ebuild generated by hackport 0.4.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="ASN1 data reader and writer in RAW, BER and DER forms"
HOMEPAGE="https://github.com/vincenthz/hs-asn1"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-haskell/asn1-types-0.3.0:=[profile?] <dev-haskell/asn1-types-0.4:=[profile?]
	>=dev-haskell/hourglass-0.2.6:=[profile?]
	dev-haskell/mtl:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.10
	test? ( dev-haskell/tasty
		dev-haskell/tasty-quickcheck
		dev-haskell/text )
"
