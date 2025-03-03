# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_TESTED=( python3_{8..10} )
# networkx skips tests w/ missing deps and the available ones all pass w/ py3.11
PYTHON_COMPAT=( "${PYTHON_TESTED[@]}" python3_11 )
inherit distutils-r1 optfeature virtualx

DESCRIPTION="Python tools to manipulate graphs and complex networks"
HOMEPAGE="
	https://networkx.org/
	https://github.com/networkx/networkx/
	https://pypi.org/project/networkx/
"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~riscv ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos"

BDEPEND="
	test? (
		>=dev-python/lxml-4.5[${PYTHON_USEDEP}]
		>=dev-python/pyyaml-3.13[${PYTHON_USEDEP}]
		$(python_gen_cond_dep '
			>=dev-python/numpy-1.19[${PYTHON_USEDEP}]
			>=dev-python/scipy-1.6.2[${PYTHON_USEDEP}]
		' "${PYTHON_TESTED[@]}")
	)
"

distutils_enable_tests pytest

src_test() {
	virtx distutils-r1_src_test
}

python_test() {
	# virtx implies nonfatal
	nonfatal epytest -p no:django || die
}

src_install() {
	distutils-r1_src_install
	# those examples use various assets and pre-compressed files
	docompress -x /usr/share/doc/${PF}/examples
}

pkg_postinst() {
	optfeature "recommended dependencies" "dev-python/matplotlib dev-python/numpy dev-python/pandas dev-python/scipy"
	optfeature "graph drawing and graph layout algorithms" "dev-python/pygraphviz dev-python/pydot"
	optfeature "YAML format reading and writing" "dev-python/pyyaml"
	optfeature "shapefile format reading and writing" "dev-python/gdal"
	optfeature "GraphML XML format" "dev-python/lxml"
}
