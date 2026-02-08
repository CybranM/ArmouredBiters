require("animation")
local setting_utils = require("setting-utils")
local sounds = require("__base__.prototypes.entity.sounds")
local ab_enemy_autoplace = require("armoured-autoplace")
local enemy_autoplace = require("__base__.prototypes.entity.enemy-autoplace-utils")
local biter_ai_settings = require("__base__.prototypes.entity.biter-ai-settings")

small_armoured_scale = 0.5
small_armoured_tint1 = settings.startup["ab-small-armoured-biter-color-primary"].value
small_armoured_tint2 = settings.startup["ab-small-armoured-biter-color-secondary"].value

medium_armoured_scale = 0.65
medium_armoured_tint1 = settings.startup["ab-medium-armoured-biter-color-primary"].value
medium_armoured_tint2 = settings.startup["ab-medium-armoured-biter-color-secondary"].value

big_armoured_scale = 0.8
big_armoured_tint1 = settings.startup["ab-big-armoured-biter-color-primary"].value
big_armoured_tint2 = settings.startup["ab-big-armoured-biter-color-secondary"].value

behemoth_armoured_scale = 1
behemoth_armoured_tint1 = settings.startup["ab-behemoth-armoured-biter-color-primary"].value
behemoth_armoured_tint2 = settings.startup["ab-behemoth-armoured-biter-color-secondary"].value

local make_unit_melee_ammo_type = function(damage_value)
    return {
        target_type = "entity",
        action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    type = "damage",
                    damage = {amount = damage_value, type = "physical"}
                }
            }
        }
    }
end

local function make_biter_area_damage(damage, radius)
    return {
        type = "area",
        radius = radius,
        force = "enemy",
        ignore_collision_condition = true,
        action_delivery = {
            type = "instant",
            target_effects = {
                {
                    type = "damage",
                    damage = {
                        amount = damage,
                        type = "physical"
                    }
                },
                {
                    type = "create-particle",
                    repeat_count = 5,
                    particle_name = "explosion-remnants-particle",
                    initial_height = 0.5,
                    speed_from_center = 0.08,
                    speed_from_center_deviation = 0.15,
                    initial_vertical_speed = 0.08,
                    initial_vertical_speed_deviation = 0.15,
                    offset_deviation = {
                        {
                            -0.2,
                            -0.2
                        },
                        {
                            0.2,
                            0.2
                        }
                    }
                }
            }
        }
    }
end

data:extend(
    {
        {
            type = "unit",
            name = "small-armoured-biter",
            order = "a-a-a",
            icon = "__ArmouredBiters__/graphics/icons/small-armoured-biter.png",
            icon_size = 64,
            flags = {
                "placeable-player",
                "placeable-enemy",
                "placeable-off-grid",
                "breaths-air",
                "not-repairable"
            },
            max_health = 50 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-health"),
            subgroup = "enemies",
            resistances = {
                {
                    type = "physical",
                    decrease = 1 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances")
                },
                {
                    type = "explosion",
                    decrease = 2 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances")
                },
                {
                    type = "fire",
                    decrease = 2 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances")
                },
                {
                    type = "laser",
                    decrease = 2 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-small-armoured-biter-resistances")
                }
            },
            healing_per_tick = 0,
            collision_box = {
                {
                    -0.3,
                    -0.3
                },
                {
                    0.3,
                    0.3
                }
            },
            selection_box = {
                {
                    -0.5,
                    -0.8
                },
                {
                    0.5,
                    0.2
                }
            },
            sticker_box = {
                {
                    -0.6,
                    -0.8
                },
                {0.6, 0}
            },
            distraction_cooldown = 300,
            min_pursue_time = 20 * 60,
            max_pursue_distance = 80,
            attack_parameters = {
                type = "projectile",
                range = 1.2,
                cooldown = 80,
                ammo_category = "melee",
                ammo_type = make_unit_melee_ammo_type(20),
                sound = sounds.biter_roars(0.4),
                animation = armoredAttackBiter(small_armoured_scale, small_armoured_tint1, small_armoured_tint2)
            },
            vision_distance = 30,
            movement_speed = 0.14,
            distance_per_frame = 0.105,
            -- in pu
            absorptions_to_join_attack = {pollution = 10},
            corpse = "small_armoured-corpse",
            dying_explosion = "blood-explosion-big",
            working_sound = sounds.biter_calls(0.4),
            dying_sound = sounds.biter_dying(0.9),
            run_animation = armoredRunBiter(small_armoured_scale, small_armoured_tint1, small_armoured_tint2),
            ai_settings = biter_ai_settings,
            walking_sound = sounds.biter_walk_big(0.2),
            running_sound_animation_positions = {
                2
            },
            damaged_trigger_effect = table.deepcopy(data.raw["unit"]["small-biter"].damaged_trigger_effect)
        },
        add_biter_armoured_die_animation(
            small_armoured_scale,
            small_armoured_tint1,
            small_armoured_tint2,
            {
                type = "corpse",
                name = "small_armoured-corpse",
                icon = "__ArmouredBiters__/graphics/icons/small-armoured-biter.png",
                icon_size = 64,
                selection_box = {
                    {
                        -0.8,
                        -0.8
                    },
                    {
                        0.8,
                        0.8
                    }
                },
                selectable_in_game = false,
                subgroup = "corpses",
                order = "c[corpse]-a[biter]-a[small]",
                flags = {
                    "placeable-neutral",
                    "placeable-off-grid",
                    "building-direction-8-way",
                    "not-repairable",
                    "not-on-map"
                }
            }
        ),
        {
            type = "unit",
            name = "medium-armoured-biter",
            order = "a-a-b",
            icon = "__ArmouredBiters__/graphics/icons/medium-armoured-biter.png",
            icon_size = 64,
            flags = {
                "placeable-player",
                "placeable-enemy",
                "placeable-off-grid",
                "breaths-air",
                "not-repairable"
            },
            max_health = 200 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-health"),
            subgroup = "enemies",
            resistances = {
                {
                    type = "physical",
                    decrease = 4 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances"),
                    percent = 20 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances")
                },
                {
                    type = "explosion",
                    decrease = 1 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances")
                },
                {
                    type = "fire",
                    decrease = 1 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances")
                },
                {
                    type = "laser",
                    decrease = 4 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances"),
                    percent = 10 * setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-resistances")
                }
            },
            healing_per_tick = 0,
            collision_box = {
                {
                    -0.3,
                    -0.3
                },
                {
                    0.3,
                    0.3
                }
            },
            selection_box = {
                {
                    -0.7,
                    -1.2
                },
                {
                    0.7,
                    0.3
                }
            },
            sticker_box = {
                {
                    -0.6,
                    -0.8
                },
                {0.6, 0}
            },
            distraction_cooldown = 300,
            min_pursue_time = 25 * 60,
            max_pursue_distance = 80,
            attack_parameters = {
                type = "projectile",
                range = 1.5,
                cooldown = 80,
                ammo_category = "melee",
                ammo_type = make_unit_melee_ammo_type(40),
                sound = sounds.biter_roars_mid(0.4),
                animation = armoredAttackBiter(medium_armoured_scale, medium_armoured_tint1, medium_armoured_tint2)
            },
            vision_distance = 30,
            movement_speed = 0.16,
            distance_per_frame = 0.119,
            -- in pu
            absorptions_to_join_attack = {pollution = 50},
            corpse = "medium-armoured-corpse",
            dying_explosion = "blood-explosion-big",
            working_sound = sounds.biter_calls(0.4),
            dying_sound = sounds.biter_dying(0.9),
            run_animation = armoredRunBiter(medium_armoured_scale, medium_armoured_tint1, medium_armoured_tint2),
            ai_settings = biter_ai_settings,
            walking_sound = sounds.biter_walk_big(0.4),
            running_sound_animation_positions = {
                2
            },
            damaged_trigger_effect = table.deepcopy(data.raw["unit"]["medium-biter"].damaged_trigger_effect)
        },
        add_biter_armoured_die_animation(
            medium_armoured_scale,
            medium_armoured_tint1,
            medium_armoured_tint2,
            {
                type = "corpse",
                name = "medium-armoured-corpse",
                icon = "__ArmouredBiters__/graphics/icons/medium-armoured-biter.png",
                icon_size = 64,
                selection_box = {
                    {
                        -0.8,
                        -0.8
                    },
                    {
                        0.8,
                        0.8
                    }
                },
                selectable_in_game = false,
                subgroup = "corpses",
                order = "c[corpse]-a[biter]-a[small]",
                flags = {
                    "placeable-neutral",
                    "placeable-off-grid",
                    "building-direction-8-way",
                    "not-repairable",
                    "not-on-map"
                }
            }
        ),
        {
            type = "unit",
            name = "big-armoured-biter",
            order = "a-a-c",
            icon = "__ArmouredBiters__/graphics/icons/big-armoured-biter.png",
            icon_size = 64,
            flags = {
                "placeable-player",
                "placeable-enemy",
                "placeable-off-grid",
                "breaths-air",
                "not-repairable"
            },
            max_health = 800 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-health"),
            subgroup = "enemies",
            resistances = {
                {
                    type = "physical",
                    decrease = 8 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances"),
                    percent = 20 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances")
                },
                {
                    type = "explosion",
                    decrease = 3 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances"),
                    percent = 15 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances")
                },
                {
                    type = "fire",
                    decrease = 2 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances"),
                    percent = 20 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances")
                },
                {
                    type = "laser",
                    decrease = 6 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances"),
                    percent = 20 * setting_utils.getPositivePercentageOf("ab-big-armoured-biter-resistances")
                }
            },
            spawning_time_modifier = 3,
            healing_per_tick = 0,
            collision_box = {
                {
                    -0.3,
                    -0.3
                },
                {
                    0.3,
                    0.3
                }
            },
            selection_box = {
                {
                    -0.8,
                    -1.4
                },
                {
                    0.8,
                    1
                }
            },
            drawing_box_vertical_extension = 0.3,
            sticker_box = {
                {
                    -0.6,
                    -0.8
                },
                {0.6, 0}
            },
            distraction_cooldown = 300,
            min_pursue_time = 30 * 60,
            max_pursue_distance = 80,
            attack_parameters = {
                type = "projectile",
                range = 1.8,
                cooldown = 80,
                ammo_category = "melee",
                ammo_type = make_unit_melee_ammo_type(80),
                sound = sounds.biter_roars_big(0.4),
                animation = armoredAttackBiter(big_armoured_scale, big_armoured_tint1, big_armoured_tint2)
            },
            vision_distance = 30,
            movement_speed = 0.18,
            distance_per_frame = 0.136,
            -- in pu
            absorptions_to_join_attack = {pollution = 200},
            corpse = "big-armoured-corpse",
            dying_explosion = "blood-explosion-big",
            working_sound = sounds.biter_calls_big(0.4),
            dying_sound = sounds.biter_dying_big(0.9),
            run_animation = armoredRunBiter(big_armoured_scale, big_armoured_tint1, big_armoured_tint2),
            ai_settings = biter_ai_settings,
            walking_sound = sounds.biter_walk_big(0.4),
            running_sound_animation_positions = {
                2
            },
            damaged_trigger_effect = table.deepcopy(data.raw["unit"]["big-biter"].damaged_trigger_effect)
        },
        add_biter_armoured_die_animation(
            big_armoured_scale,
            big_armoured_tint1,
            big_armoured_tint2,
            {
                type = "corpse",
                name = "big-armoured-corpse",
                icon = "__ArmouredBiters__/graphics/icons/big-armoured-biter.png",
                icon_size = 64,
                selection_box = {
                    {
                        -0.8,
                        -0.8
                    },
                    {
                        0.8,
                        0.8
                    }
                },
                selectable_in_game = false,
                subgroup = "corpses",
                order = "c[corpse]-a[biter]-a[small]",
                flags = {
                    "placeable-neutral",
                    "placeable-off-grid",
                    "building-direction-8-way",
                    "not-repairable",
                    "not-on-map"
                }
            }
        ),
        {
            type = "unit",
            name = "behemoth-armoured-biter",
            order = "a-a-d",
            icon = "__ArmouredBiters__/graphics/icons/behemoth-armoured-biter.png",
            icon_size = 64,
            flags = {
                "placeable-player",
                "placeable-enemy",
                "placeable-off-grid",
                "breaths-air",
                "not-repairable"
            },
            max_health = 6000 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-health"),
            subgroup = "enemies",
            resistances = {
                {
                    type = "physical",
                    decrease = 12 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances"),
                    percent = 25 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances")
                },
                {
                    type = "explosion",
                    decrease = 12 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances"),
                    percent = 25 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances")
                },
                {
                    type = "fire",
                    decrease = 4 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances"),
                    percent = 40 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances")
                },
                {
                    type = "laser",
                    decrease = 10 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances"),
                    percent = 20 * setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-resistances")
                }
            },
            spawning_time_modifier = 12,
            healing_per_tick = 0,
            collision_box = {
                {
                    -0.4,
                    -0.4
                },
                {
                    0.4,
                    0.4
                }
            },
            selection_box = {
                {
                    -1,
                    -1.6
                },
                {
                    1,
                    1
                }
            },
            drawing_box_vertical_extension = 0.5,
            sticker_box = {
                {
                    -0.6,
                    -0.8
                },
                {0.6, 0}
            },
            distraction_cooldown = 300,
            min_pursue_time = 30 * 60,
            max_pursue_distance = 80,
            attack_parameters = {
                type = "projectile",
                range = 2.2,
                cooldown = 80,
                sound = sounds.biter_roars_behemoth(0.4),
                animation = armoredAttackBiter(
                    behemoth_armoured_scale,
                    behemoth_armoured_tint1,
                    behemoth_armoured_tint2
                ),
                ammo_category = "melee",
                ammo_type = {
                    target_type = "entity",
                    action = {
                        {
                            action_delivery = {
                                target_effects = {
                                    damage = {
                                        amount = (200),
                                        type = "physical"
                                    },
                                    type = "damage",
                                    show_in_tooltip = true
                                },
                                type = "instant"
                            },
                            type = "direct"
                        },
                        make_biter_area_damage(50, 1)
                    }
                }
            },
            vision_distance = 30,
            movement_speed = 0.2,
            distance_per_frame = 0.17,
            -- in pu
            absorptions_to_join_attack = {pollution = 1000},
            corpse = "behemoth-armoured-corpse",
            dying_explosion = "blood-explosion-big",
            working_sound = sounds.biter_calls_big(0.4),
            dying_sound = sounds.biter_dying_big(0.9),
            run_animation = armoredRunBiter(behemoth_armoured_scale, behemoth_armoured_tint1, behemoth_armoured_tint2),
            ai_settings = biter_ai_settings,
            walking_sound = sounds.biter_walk_big(0.5),
            running_sound_animation_positions = {
                2
            },
            damaged_trigger_effect = table.deepcopy(data.raw["unit"]["behemoth-biter"].damaged_trigger_effect)
        },
        add_biter_armoured_die_animation(
            behemoth_armoured_scale,
            behemoth_armoured_tint1,
            behemoth_armoured_tint2,
            {
                type = "corpse",
                name = "behemoth-armoured-corpse",
                icon = "__ArmouredBiters__/graphics/icons/behemoth-armoured-biter.png",
                icon_size = 64,
                selection_box = {
                    {
                        -0.8,
                        -0.8
                    },
                    {
                        0.8,
                        0.8
                    }
                },
                selectable_in_game = false,
                subgroup = "corpses",
                order = "c[corpse]-a[biter]-a[small]",
                flags = {
                    "placeable-neutral",
                    "placeable-off-grid",
                    "building-direction-8-way",
                    "not-repairable",
                    "not-on-map"
                }
            }
        )
    }
)

local s_r = setting_utils.getPositivePercentageOf("ab-small-armoured-biter-spawn-probability")
local m_r = setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-spawn-probability")
local b_r = setting_utils.getPositivePercentageOf("ab-big-armoured-biter-spawn-probability")
local bb_r = setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-spawn-probability")
local l_r = setting_utils.getPositivePercentageOf("ab-leviathan-armoured-biter-spawn-probability")

local result_units = {
    {
        "small-armoured-biter",
        {
            {
                0.0,
                0.3 * s_r
            },
            {
                0.6,
                0.0
            }
        }
    },
    {
        "medium-armoured-biter",
        {
            {
                0.2,
                0.0
            },
            {
                0.6,
                0.3 * m_r
            },
            {
                0.7,
                0.1 * m_r
            }
        }
    },
    {
        "big-armoured-biter",
        {
            {
                0.5,
                0.0
            },
            {
                1.0,
                0.4 * b_r
            }
        }
    },
    {
        "behemoth-armoured-biter",
        {
            {
                0.9,
                0.0
            },
            {
                1.0,
                0.3 * bb_r
            }
        }
    }
}

local res_mp = setting_utils.getPositivePercentageOf("ab-leviathan-armoured-biter-resistances")
local leviathan_resists = {
    {
        type = "physical",
        decrease = 12 * res_mp,
        percent = 25 * res_mp
    },
    {
        type = "explosion",
        decrease = 12 * res_mp,
        percent = 25 * res_mp
    },
    {
        type = "laser",
        decrease = 10 * res_mp,
        percent = 20 * res_mp
    },
    {
        type = "impact",
        decrease = 20 * res_mp,
        percent = 40 * res_mp
    },
    {
        type = "fire",
        decrease = 4 * res_mp,
        percent = 40 * res_mp
    }
}

local leviathan_scale = 1.25
local leviathan_tint1 = settings.startup["ab-leviathan-armoured-biter-color-primary"].value
local leviathan_tint2 = settings.startup["ab-leviathan-armoured-biter-color-secondary"].value

if l_r > 0 then
    table.insert(
        result_units,
        {
            "leviathan-armoured-biter",
            {
                {
                    0.965,
                    0.0
                },
                {
                    1.0,
                    0.06 * l_r
                }
            }
        }
    )

    data:extend(
        {
            {
                type = "unit",
                name = "leviathan-armoured-biter",
                order = "a-a-e",
                icon = "__ArmouredBiters__/graphics/icons/leviathan-armoured-biter.png",
                icon_size = 64,
                flags = {
                    "placeable-player",
                    "placeable-enemy",
                    "placeable-off-grid",
                    "breaths-air",
                    "not-repairable"
                },
                max_health = 18000 * setting_utils.getPositivePercentageOf("ab-leviathan-armoured-biter-health"),
                subgroup = "enemies",
                resistances = leviathan_resists,
                spawning_time_modifier = 12,
                healing_per_tick = 0,
                collision_box = {
                    {
                        -0.4,
                        -0.4
                    },
                    {
                        0.4,
                        0.4
                    }
                },
                selection_box = {
                    {
                        -1,
                        -1.8
                    },
                    {
                        1,
                        1
                    }
                },
                drawing_box_vertical_extension = 0.7,
                sticker_box = {
                    {
                        -0.6,
                        -0.8
                    },
                    {
                        0.6,
                        0
                    }
                },
                distraction_cooldown = 300,
                min_pursue_time = 30 * 60,
                max_pursue_distance = 100,
                attack_parameters = {
                    type = "projectile",
                    range = 2.2,
                    cooldown = 60,
                    sound = sounds.biter_roars_behemoth(1),
                    animation = armoredAttackBiter(leviathan_scale, leviathan_tint1, leviathan_tint2),
                    ammo_category = "melee",
                    ammo_type = {
                        target_type = "entity",
                        action = {
                            {
                                action_delivery = {
                                    target_effects = {
                                        damage = {
                                            amount = (350),
                                            type = "physical"
                                        },
                                        type = "damage",
                                        show_in_tooltip = true
                                    },
                                    type = "instant"
                                },
                                type = "direct"
                            },
                            make_biter_area_damage(100, 2)
                        }
                    }
                },
                vision_distance = 40,
                movement_speed = 0.3,
                distance_per_frame = 0.17,
                -- in pu
                absorptions_to_join_attack = {pollution = 2000},
                corpse = "leviathan-armoured-corpse",
                dying_explosion = "blood-explosion-big",
                working_sound = sounds.biter_calls_big(1.0),
                dying_sound = sounds.biter_dying_big(1),
                walking_sound = sounds.biter_walk_big(0.8),
                running_sound_animation_positions = {
                    2
                },
                damaged_trigger_effect = table.deepcopy(data.raw["unit"]["behemoth-biter"].damaged_trigger_effect),
                run_animation = armoredRunBiter(leviathan_scale, leviathan_tint1, leviathan_tint2),
                ai_settings = biter_ai_settings
            },
            add_biter_armoured_die_animation(
                leviathan_scale,
                leviathan_tint1,
                leviathan_tint2,
                {
                    type = "corpse",
                    name = "leviathan-armoured-corpse",
                    icon = "__ArmouredBiters__/graphics/icons/leviathan-armoured-biter.png",
                    icon_size = 64,
                    selection_box = {
                        {
                            -2.5,
                            -1.8
                        },
                        {
                            2.5,
                            1.8
                        }
                    },
                    selectable_in_game = false,
                    subgroup = "corpses",
                    order = "c[corpse]-a[biter]-a[small]",
                    flags = {
                        "placeable-neutral",
                        "placeable-off-grid",
                        "building-direction-8-way",
                        "not-repairable",
                        "not-on-map"
                    }
                }
            )
        }
    )
end

local biterSpawner = data.raw["unit-spawner"]["biter-spawner"]

if settings.startup["ab-enable-nest"].value then
    
    ab_enemy_autoplace = Armoured_get_autoplace_base("0")

    local nest_tint = {
        r = 0.36,
        g = 0.98,
        b = 0.38,
        a = 1
    }

    data:extend(
        {
            {
                type = "unit-spawner",
                name = "armoured-biter-spawner",
                icon = "__base__/graphics/icons/biter-spawner.png",
                icon_size = 64,
                flags = {
                    "placeable-player",
                    "placeable-enemy",
                    "not-repairable"
                },
                max_health = 650,
                order = "b-b-g",
                subgroup = "enemies",
                resistances = {
                    {
                        type = "explosion",
                        decrease = 5,
                        percent = 25
                    },
                    {
                        type = "fire",
                        decrease = 3,
                        percent = 60
                    },
                    {
                        type = "laser",
                        decrease = 10,
                        percent = 20
                    },
                    {
                        type = "physical",
                        decrease = 4,
                        percent = 20
                    }
                },
                working_sound = {
                    sound = {
                        {
                            filename = "__base__/sound/creatures/spawner.ogg",
                            volume = 1.0
                        }
                    },
                    apparent_volume = 2
                },
                dying_sound = {
                    {
                        filename = "__base__/sound/creatures/spawner-death-1.ogg",
                        volume = 1.0
                    },
                    {
                        filename = "__base__/sound/creatures/spawner-death-2.ogg",
                        volume = 1.0
                    }
                },
                healing_per_tick = 0.02,
                collision_box = {
                    {
                        -3.2,
                        -2.2
                    },
                    {
                        2.2,
                        2.2
                    }
                },
                map_generator_bounding_box = {
                    {
                        -4.2,
                        -3.2
                    },
                    {
                        3.2,
                        3.2
                    }
                },
                selection_box = {
                    {
                        -3.5,
                        -2.5
                    },
                    {
                        2.5,
                        2.5
                    }
                },
                -- in ticks per 1 pu
                absorptions_per_second = {pollution = {absolute = 20, proportional = 0.01}},
                corpse = "armoured-biter-spawner-corpse",
                dying_explosion = "blood-explosion-huge",
                max_count_of_owned_units = 10,
                max_friends_around_to_spawn = 7,
                graphics_set = {
                    animations = {
                        armoured_spawner_idle_animation(0, nest_tint)
                    }
                },
                integration = {
                    sheet = spawner_armoured_integration()
                },
                result_units = result_units,
                -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
                spawning_cooldown = {
                    360,
                    150
                },
                spawning_radius = 10,
                spawning_spacing = 3,
                max_spawn_shift = 0,
                max_richness_for_spawn_shift = 100,
                autoplace = ab_enemy_autoplace,
                damaged_trigger_effect = table.deepcopy(
                    data.raw["unit-spawner"]["biter-spawner"].damaged_trigger_effect
                ),
                call_for_help_radius = 50
            },
            {
                type = "corpse",
                name = "armoured-biter-spawner-corpse",
                flags = {
                    "placeable-neutral",
                    "placeable-off-grid",
                    "not-on-map"
                },
                icon = "__base__/graphics/icons/biter-spawner-corpse.png",
                icon_size = 64,
                collision_box = {
                    {
                        -2,
                        -2
                    },
                    {
                        2,
                        2
                    }
                },
                selection_box = {
                    {
                        -2,
                        -2
                    },
                    {
                        2,
                        2
                    }
                },
                selectable_in_game = false,
                dying_speed = 0.04,
                time_before_removed = 15 * 60 * 60,
                subgroup = "corpses",
                order = "c[corpse]-b[biter-spawner]",
                final_render_layer = "remnants",
                animation = {
                    spawner_die_animation(1, nest_tint)
                },
                decay_animation = spawner_decay_animation(1, nest_tint),
                decay_frame_transition_duration = 6 * 60,
                --[[ ground_patch = {
                    sheet = spawner_armoured_integration()
                } ]]
            }
        }
    )
    data.raw["unit-spawner"]["armoured-biter-spawner"].integration =
        data.raw["unit-spawner"]["biter-spawner"].integration
else
    if biterSpawner then
        local s_r = setting_utils.getPositivePercentageOf("ab-small-armoured-biter-spawn-probability")
        local m_r = setting_utils.getPositivePercentageOf("ab-medium-armoured-biter-spawn-probability")
        local b_r = setting_utils.getPositivePercentageOf("ab-big-armoured-biter-spawn-probability")
        local bb_r = setting_utils.getPositivePercentageOf("ab-behemoth-armoured-biter-spawn-probability")
        local unitSet = biterSpawner["result_units"]
        unitSet[#unitSet + 1] = {
            "small-armoured-biter",
            {
                {
                    0.0,
                    0.3 * s_r
                },
                {
                    0.6,
                    0.0
                }
            }
        }
        unitSet[#unitSet + 1] = {
            "medium-armoured-biter",
            {
                {
                    0.2,
                    0.0
                },
                {
                    0.6,
                    0.3 * m_r
                },
                {
                    0.7,
                    0.1 * m_r
                }
            }
        }
        unitSet[#unitSet + 1] = {
            "big-armoured-biter",
            {
                {
                    0.5,
                    0.0
                },
                {
                    1.0,
                    0.4 * b_r
                }
            }
        }
        unitSet[#unitSet + 1] = {
            "behemoth-armoured-biter",
            {
                {
                    0.9,
                    0.0
                },
                {
                    1.0,
                    0.3 * bb_r
                }
            }
        }

        if l_r > 0 then
            unitSet[#unitSet + 1] = {
                "leviathan-armoured-biter",
                {
                    {
                        0.965,
                        0.0
                    },
                    {
                        1.0,
                        0.06 * l_r
                    }
                }
            }
        end
    end
end
