local format = require "advanced_statistics/gui/format"
local style = require "advanced_statistics/gui/style"
local guio = require "advanced_statistics/gui/objects"
local a,v,s,o = require "advanced_statistics/adv".sks()

local difficulty = {
	_("Easy"),
	_("Medium"),
	_("Hard"),
}
local speedicons = {
	"ui/button/small/pause.tga",
	"ui/button/small/play.tga",
	"ui/button/small/play_2.tga",
	"ui/button/small/play_3.tga",
}

return {
	name = _("Game Information"),
	-- icon = "ui/icons/warnings/stop_watch.tga",
	-- icon = "ui/save.tga",
	gamebartext = function(data) return
		format.TimeHrs(data.gametime.time)
		-- format.TimeHrs(data.gametimetotal)
	end,
	gamebartooltip = function(data)
		return format.lines{
			string.format("%s (%s):  %s", _("Game Time"), _("Simulation"), format.TimeHrs(data.gametime.time) ),
			string.format("%s (%s):  %s", _("Game Time"), _("Total"), format.TimeHrs(data.gametimetotal) ),
		}
	end,
	header = false,
	windowlayout = function(updatedata) return {
		{ table = {
			{
				_("Name"),
				{ text = function(data) return
					data.name
				end,
				style = "AVSPlayerName", }
			}, {
				_("Company Score"),
				{ text = function(data) return
					string.format("%d", data.score)
				end,
				style = "AVSCompanyScore" }
			}, {
				_("Game Difficulty"),
				function(data) return
					string.format("%s (%d)", difficulty[data.difficulty+1], data.difficulty)
				end
			}, {
				_("Sandbox"),
				guio.CheckHook(updatedata().isSandbox),
			}, {
				_("No Costs"),
				guio.CheckHook(updatedata().noCosts)
			}, {
				_("Map Size"),
				function(data)
					local size = data.worldsize
					return string.format("%s  x  %s  =  %s²", format.Length(size.x),  format.Length(size.y),  format.Length(size.x*size.y) )
				end
			}
		}},
		
		"<hline>",
		{ table = {
			{
				{
					text = _("Game Time").." (".._("Simulation")..")",
					tooltip = _("gametimeTT"),
				},
				{	layout = { type = "BoxH", content = {
					{
						text = function(data) return
							format.TimeHrs(data.gametime.time)
						end,
						tooltip = function(data) 
							local time = data.gametime.time
							return format.lines{
								format.TimeHrs(time), 
								format.TimeMin(time), 
								format.TimeSec(time),
								string.format("%s: %d", _("Update Count"), data.updateCount)
							}
						end
					},{
						icon = function(data) return
							speedicons[(data.speed<4) and data.speed+1 or 4]
						end,
						tooltip = function(data) return
							string.format("%s: %d", _("Simulation Speed"), data.speed)
						end
					}, 
				} }},
			},{
				{
					text = _("Game Time")..format.str.total,
					tooltip = _("gametimeTotTT"),
				},
				{	layout = { type = "BoxH", content = {
					{
						text = function(data) return
							format.TimeHrs(data.gametimetotal)
						end,
						tooltip = function(data) 
							local time = data.gametimetotal
							return format.lines{
								format.TimeHrs(time), 
								format.TimeMin(time), 
								format.TimeSec(time),
								string.format("%s: %d", _("Tick Count"), data.tickCount)
							}
						end
					}
				} }},
			},{
				_("Game Date"),
				{	layout = { type = "BoxH", content = {
					nil and {
						icon = "",
					}, {
						text = function(data) return
							format.GameTimeDate(data.gametime.date)
						end,
						-- tooltip = function(data) return
							
						-- end
					}
				} }},
			}, {
				_("Milliseconds per day"),
				function(data) return
					data.millis and string.format("%d", data.millis) or "-"
				end
			}
		}},
		
		
		"<hline>",
		{ table = {
			{
				_("Balance"),
				{ text = function(data) return
					format.Money(data.account.balance)
				end,
				style = function(data) return
					style.finance(data.account.balance)
				end }
			}, {
				_("Loan"),
				{ text = function(data) return
					format.Money(data.account.loan)
				end,
				style = function(data) return
					style.finance(data.account.loan)
				end }
			}, {
				_("Maximum Loan"),
				{ text = function(data) return
					format.Money(data.account.maximumLoan)
				end,
				style = function(data) return
					style.finance(data.account.maximumLoan)
				end }
			}, {
				_("Total"),
				{ text = function(data) return
					format.Money(data.account.total)
				end,
				style = function(data) return
					style.finance(data.account.total)
				end }
			},
		}},
		a{ table = {
			{
				_("Income")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal.income._sum)
				end,
				style = function(data) return
					style.finance(data.journal.income._sum)
				end }
			}, {
				_("Maintenance")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal.maintenance._sum)
				end,
				style = function(data) return
					style.finance(data.journal.maintenance._sum)
				end }
			}, {
				_("Acquisition")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal.acquisition._sum)
				end,
				style = function(data) return
					style.finance(data.journal.acquisition._sum)
				end }
			}, {
				_("ConstructionJournal")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal.construction._sum)
				end,
				style = function(data) return
					style.finance(data.journal.construction._sum)
				end }
			}, {
				_("Interest")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal.interest)
				end,
				style = function(data) return
					style.finance(data.journal.interest)
				end }
			}, {
				_("Sum")..format.str.total,
				{ text = function(data) return
					format.Money(data.journal._sum)
				end,
				style = function(data) return
					style.finance(data.journal._sum)
				end }
			}
		}},
		
		"<hline>",
		{ table = {
			{
				{ layout = { type = "BoxH",
					content = {
						{
							-- icon = "ui/icons/construction-menu/filter_passengers.tga",
							icon = "ui/advanced_statistics/person.tga",
						}, {
							text = _("Transported Passengers"),
							-- tooltip = 
						}
					}
				} },
				function(data) return
					format.Number(data.transported.passengers)
				end
			},{
				{ layout = { type = "BoxH",
					content = {
						{
							icon = "ui/icons/construction-menu/filter_cargo.tga",
						}, {
							text = _("Transported Cargo"),
							-- tooltip = 
						}
					}
				} },
				function(data) return
					format.Number(data.transported.cargo)
				end
			},
		}},
		-- "<hline>",
		-- { table = {
			-- {
				-- {	text = _("Entities"),
					-- tooltip = _("entitiesTT"),
				-- },
				-- function(data) return
					-- tostring(data.entities)
				-- end,
			-- }
		-- }},
		
		
	} end
}