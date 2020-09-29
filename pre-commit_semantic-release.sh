#!/bin/sh
set -o nounset # Treat unset variables as an error and immediately exit
set -o errexit # If a command fails exit the whole script

###############################################################################
# (A) Update `FORMULA` with `${nextRelease.version}`
###############################################################################
sed -i -e "s_^\(version:\).*_\1 ${1}_" FORMULA

###############################################################################
# (B) Use `maintainer` to update AUTHORS.md
###############################################################################

export MAINTAINER_TOKEN=${GH_TOKEN}
go get github.com/myii/maintainer
maintainer contributor

###############################################################################
# (B) Use `m2r` to convert automatically produced `.md` docs to `.rst`
###############################################################################

# Install `m2r`
sudo -H pip install m2r

# Copy and then convert the `.md` docs
cp ./*.md docs/
cd docs/ || exit
m2r --overwrite ./*.md

# Change excess `H1` headings to `H2` in converted `CHANGELOG.rst`
sed -i -e '/^=.*$/s/=/-/g' CHANGELOG.rst
sed -i -e '1,4s/-/=/g' CHANGELOG.rst

# Use for debugging output, when required
# cat AUTHORS.rst
# cat CHANGELOG.rst

# Return back to the main directory
cd ..
