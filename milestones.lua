return {
    ["Armoured Biters"] = {
        required_mods = {script.mod_name},
        forbidden_mods = {"SeaBlock"},
        milestones = {
            {type="group", name="Kills"},
            {type="kill", name="behemoth-armoured-biter", quantity=1},
            {type="kill", name="leviathan-armoured-biter", quantity=1},
        }
    }
}
