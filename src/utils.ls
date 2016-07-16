

{nano-ajax,most,_,h,lo} = require './external.js'


get-file = _.curry (input,add,end,error) ->

	code,responeText <- nano-ajax.ajax input

	add [code,responeText]

	end!


create-css-head = (style-sheets) -> 

	links = []

	hooks = []

	for I in style-sheets

		elm = h 'link',(attrs:(rel:"stylesheet",type:'text/css',href:I))

		hook = {}

		elm.data.hook = hook

		hooks.push hook

		links.push elm

	output-node = h 'head',links


	postpatch-stream = most.create (add) !->

		output-node.data.hook = postpatch: (old-v-node,vnode) -> add vnode


	onload-stream = do

		(node) <- postpatch-stream.chain

		onload-stream = do

			(add) <- most.create

			for I in node.children

				I.elm.onload = add

		.skip (style-sheets.length - 1)

	[output-node,onload-stream]


get-stream = ([streamType1,streamType2],vnode) ->

	if vnode.data[streamType1] is undefined
		vnode.data[streamType1] = {}


		entry = vnode.data[streamType1]

	(add) <-! most.create 

	entry[streamType2] = add


Normalize = (EventName) ->

	TypeOfEvent = typeof EventName

	switch TypeOfEvent

	| "string" => 

		Output = [(eventName:EventName,children:[])]

	| "object" => 

		if Array.isArray EventName

			Output = []

			for I in EventName

				Output.push Normalize I

		else

			if EventName.children is undefined
				EventName.children = []
			else
				Child = Normalize EventName.children
				EventName.children = Child

			Output = [EventName]

	lo.flatten Output


events$ = (update) -> (EventName) ->

	NormalizedEventName = Normalize EventName

	(EventOb) !->
		for I in NormalizedEventName
			update I,arguments[0]



module.exports = 
	get-file:(input) -> most.create get-file input
	create-css-head:create-css-head
	wait:(time,f) -> setTimeout f,time
	get-stream:get-stream
	events$:events$
