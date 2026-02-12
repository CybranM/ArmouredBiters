data:extend(
    {
        --[[ small biter ]]
        {
            type = "string-setting",
            name = "ab-small-armoured-biter-health",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "a1"
        },
        {
            type = "string-setting",
            name = "ab-small-armoured-biter-resistances",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "a2"
        },
        {
            type = "string-setting",
            name = "ab-small-armoured-biter-spawn-probability",
            setting_type = "startup",
            default_value = "75%",
            allowed_values = {"25%", "50%", "75%", "100%", "125%", "150%", "200%", "300%", "400%"},
            order = "a3"
        },
        {
            type = "color-setting",
            name = "ab-small-armoured-biter-color-primary",
            setting_type = "startup",
            default_value = {
                r = 0.93,
                g = 0.94,
                b = 0.72,
                a = 0.6
            },
            order = "a4"
        },
        {
            type = "color-setting",
            name = "ab-small-armoured-biter-color-secondary",
            setting_type = "startup",
            default_value = {
                r = 0.9,
                g = 0.83,
                b = 0.54,
                a = 1
            },
            order = "a4"
        },
        --[[ medium biter ]]
        {
            type = "string-setting",
            name = "ab-medium-armoured-biter-health",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "b1"
        },
        {
            type = "string-setting",
            name = "ab-medium-armoured-biter-resistances",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "b2"
        },
        {
            type = "string-setting",
            name = "ab-medium-armoured-biter-spawn-probability",
            setting_type = "startup",
            default_value = "75%",
            allowed_values = {"25%", "50%", "75%", "100%", "125%", "150%", "200%", "300%", "400%"},
            order = "b3"
        },
        {
            type = "color-setting",
            name = "ab-medium-armoured-biter-color-primary",
            setting_type = "startup",
            default_value = {
                r = 0.49,
                g = 0.46,
                b = 0.51,
                a = 0.8
            },
            order = "b4"
        },
        {
            type = "color-setting",
            name = "ab-medium-armoured-biter-color-secondary",
            setting_type = "startup",
            default_value = {
                r = 0.93,
                g = 0.72,
                b = 0.72,
                a = 1
            },
            order = "b4"
        },
        --[[ big biter ]]
        {
            type = "string-setting",
            name = "ab-big-armoured-biter-health",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "c1"
        },
        {
            type = "string-setting",
            name = "ab-big-armoured-biter-resistances",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "c2"
        },
        {
            type = "string-setting",
            name = "ab-big-armoured-biter-spawn-probability",
            setting_type = "startup",
            default_value = "75%",
            allowed_values = {"25%", "50%", "75%", "100%", "125%", "150%", "200%", "300%", "400%"},
            order = "c3"
        },
        {
            type = "color-setting",
            name = "ab-big-armoured-biter-color-primary",
            setting_type = "startup",
            default_value = {
                r = 0.53,
                g = 0.65,
                b = 0.90,
                a = 0.8
            },
            order = "c4"
        },
        {
            type = "color-setting",
            name = "ab-big-armoured-biter-color-secondary",
            setting_type = "startup",
            default_value = {
                r = 0.56,
                g = 0.54,
                b = 0.98,
                a = 1
            },
            order = "c4"
        },
        --[[ behemoth biter ]]
        {
            type = "string-setting",
            name = "ab-behemoth-armoured-biter-health",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "d1"
        },
        {
            type = "string-setting",
            name = "ab-behemoth-armoured-biter-resistances",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "d2"
        },
        {
            type = "string-setting",
            name = "ab-behemoth-armoured-biter-spawn-probability",
            setting_type = "startup",
            default_value = "75%",
            allowed_values = {"25%", "50%", "75%", "100%", "125%", "150%", "200%", "300%", "400%"},
            order = "d3"
        },
        {
            type = "color-setting",
            name = "ab-behemoth-armoured-biter-color-primary",
            setting_type = "startup",
            default_value = {
                r = 0.41,
                g = 0.63,
                b = 0.40,
                a = 1
            },
            order = "d4"
        },
        {
            type = "color-setting",
            name = "ab-behemoth-armoured-biter-color-secondary",
            setting_type = "startup",
            default_value = {
                r = 0.44,
                g = 1,
                b = 0.29,
                a = 1
            },
            order = "d4"
        },
        --[[ leviathan biter ]]
        {
            type = "string-setting",
            name = "ab-leviathan-armoured-biter-health",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "e1"
        },
        {
            type = "string-setting",
            name = "ab-leviathan-armoured-biter-resistances",
            setting_type = "startup",
            default_value = "100%",
            allowed_values = {"50%", "75%", "100%", "125%", "150%", "200%", "250%", "300%", "350%", "400%", "450%", "500%", "550%", "600%", "700%", "800%", "900%", "1000%"},
            order = "e2"
        },
        {
            type = "string-setting",
            name = "ab-leviathan-armoured-biter-spawn-probability",
            setting_type = "startup",
            default_value = "50%",
            allowed_values = {"0%", "25%", "50%", "75%", "100%", "125%", "150%", "200%", "300%", "400%"},
            order = "e3"
        },
        {
            type = "color-setting",
            name = "ab-leviathan-armoured-biter-color-primary",
            setting_type = "startup",
            default_value = {
                r = 0.9,
                g = 0.23,
                b = 0.23,
                a = 0.95
            },
            order = "e4"
        },
        {
            type = "color-setting",
            name = "ab-leviathan-armoured-biter-color-secondary",
            setting_type = "startup",
            default_value = {
                r = 0.78,
                g = 0.84,
                b = 0,
                a = 0.9
            },
            order = "e4"
        },
        --[[ other settings ]]
        {
            type = "bool-setting",
            name = "ab-enable-nest",
            setting_type = "startup",
            default_value = true,
            order = "m",
            per_user = false
        },
        {
            type = "bool-setting",
            name = "ab-enable-moisture-check",
            setting_type = "startup",
            default_value = false,
            order = "n",
            per_user = false
        }
    }
)
