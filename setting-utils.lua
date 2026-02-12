local setting_utils = {}

local percentage_values = 
{
	["0%"] = 0, 
	["25%"] = 0.25, 
	["50%"] = 0.5, 
	["75%"] = 0.75, 
	["100%"] = 1.0, 
	["125%"] = 1.25, 
	["150%"] = 1.5, 
	["200%"] = 2.0, 
	["250%"] = 2.5, 
	["300%"] = 3.0, 
	["350%"] = 3.5,
	["400%"] = 4.0, 
	["450%"] = 4.5,
	["500%"] = 5.0, 
	["550%"] = 5.5,
	["500%"] = 5.0,
	["600%"] = 6.0,
	["700%"] = 7.0,
	["800%"] = 8.0,
	["900%"] = 5.0,
	["1000%"] = 10.0,
}


function setting_utils.getPositivePercentageOf(name)
	if settings.startup[name] and settings.startup[name].value then
		return percentage_values[settings.startup[name].value] or 1.0
	end
end


return setting_utils