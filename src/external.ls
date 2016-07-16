H = {}

snabbdom = require "snabbdom/snabbdom"

H.patch = snabbdom.init [
	require 'snabbdom/modules/class'
	require 'snabbdom/modules/props'
	require 'snabbdom/modules/style'
	require 'snabbdom/modules/eventlisteners'
	require "snabbdom/modules/attributes"
	]

H.h = require "snabbdom/h"

H._ = require "ramda"

H.vjs = require "velocity-commonjs"

H.nano-ajax = require 'nanoajax'

H.most = require 'most'

H.lo = require 'lodash'

H.nv = require '../vendors/nv.d3'

H.d3 = require '../vendors/d3'

H.colors = require '@partially-applied/material-colors'

H.table = require '@partially-applied/material-table'

H.dropdown = require '@partially-applied/material-dropdown'

module.exports = H
