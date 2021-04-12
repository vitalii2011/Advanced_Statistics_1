local format = require "advanced_statistics/gui/format"
local res = require "advanced_statistics/script/res/railroadcrossing"
local guio = require "advanced_statistics/gui/objects"
local a,v,s = require "advanced_statistics/adv".sks()

return {
	-- icon = "ui/advanced_statistics/crossing.tga",
	name = _("Railroad Crossings"),
	gamebartext = function(data) return
		tostring(data.count)
	end,
	-- gamebartooltip = function(data) return
		-- string.format(" ",  )
	-- end,
	windowlayout = function(updatedata) return {
		{ table = {
			{
				_("Count"),
				function(data) return
					tostring(data.count)
				end
			}
		}},
		
		"<hline>",
		{	text = _("States"),
			style = "AVSHeading2"
		},
		{ table = {
			{
				_("State").." ".._("Open"),
				function(data) return
					tostring(data.States[1])
				end
			},{
				_("State").." ".._("Closed"),
				function(data) return
					tostring(data.States[2])
				end
			},
		}},
		
		"<hline>",
		{	text = _("Activation"),
			style = "AVSHeading2"
		},
		{ table = {
			{
				_("Last Activated")..(" (".._("Latest")..")"),
				function(data) return
					format.Age(data.StTimes.max/1e3)
				end
			},
			a{
				_("Last Activated")..format.str.av,
				function(data) return
					data.StTimes.av and format.Age(data.StTimes.av/1e3) or "-"
				end
			},
			{
				_("Last Activated").." (".._("Oldest")..")",
				function(data) return
					format.Age(data.StTimes.min/1e3)
				end
			},
			{
				_("Never Activated"),
				function(data) return
					tostring(data.count-data.StTimes.num)
				end
			},
		}},
		
		"<hline>",
		{	text = _("List"),
			style = "AVSHeading2"
		},
		guio.ResList( function() return updatedata().types end, res.names, nil ),
		
	} end
}