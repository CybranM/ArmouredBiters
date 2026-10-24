local milestones = require("milestones")

remote.add_interface(script.mod_name, {
    milestones_preset_addons = function()
        return milestones
    end
})
