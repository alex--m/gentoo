# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

USE_RUBY="ruby26 ruby27 ruby30 ruby31"

RUBY_FAKEGEM_RECIPE_TEST="rspec3"
RUBY_FAKEGEM_TASK_DOC="yard"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

inherit ruby-fakegem

DESCRIPTION="A generic swappable back-end for XML parsing"
HOMEPAGE="https://www.rubydoc.info/gems/multi_xml"
SRC_URI="https://github.com/sferik/multi_xml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE=""

ruby_add_bdepend "doc? ( dev-ruby/yard )"
ruby_add_bdepend "test? ( dev-ruby/ox )"

all_ruby_prepare() {
	eapply "${FILESDIR}/${P}-ox24.patch"

	sed -i -e '/simplecov/,/^end/ s:^:#:' spec/helper.rb || die
	sed -e '/bundler/I s:^:#:' \
		-e '/yardstick/,/end/ s:^:#:' \
		-e '/rubocop/I s:^:#:' \
		-i Rakefile || die
}

each_ruby_test() {
	CI=true each_fakegem_test
}
