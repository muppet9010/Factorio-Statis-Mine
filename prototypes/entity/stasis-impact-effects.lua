local Utils = require("utility/utils")
local Constants = require("constants")

-- The visual effect done on an affected entity for the duration of the effect.
local targetEffect = {
    type = "smoke-with-trigger",
    name = "stasis_mine-stasis_target_impact_effect",
    flags = { "placeable-off-grid" },
    animation = {
        filename = Constants.AssetModName .. "/graphics/entity/stasis_impact_effect-hr.png",
        flags = { "trilinear-filtering" },
        line_length = 4,
        width = 364,
        height = 372,
        frame_count = 16,
        direction_count = 1,
        tint = nil,
        scale = 1 / 4
    },
    duration = tonumber(settings.startup["stasis_mine-stasis_time"].value) * 60,
    fade_in_duration = 120,
    fade_away_duration = 30,
    movement_slow_down_factor = 0,
    cyclic = true,
    affected_by_wind = false,
    show_when_smoke_off = true
}

-- The initial detonation effect done where the stasis weapon goes off to cover its affected area briefly.
local sourceEffect = Utils.DeepCopy(targetEffect)
sourceEffect.name = "stasis_mine-stasis_source_impact_effect"
sourceEffect.animation.scale = tonumber(settings.startup["stasis_mine-stasis_effect_area"].value) / 4
sourceEffect.duration = 30
sourceEffect.start_scale = 0.5 / 4
sourceEffect.fade_in_duration = 10
sourceEffect.fade_away_duration = 10

-- The effect when a landmine dies. Shows a small stasis effect when a landmine is killed, like its done a mini failed stasis detonation.
local dyingEffect = Utils.DeepCopy(targetEffect)
dyingEffect.name = "stasis_mine-stasis_dying_effect"
dyingEffect.duration = 30
dyingEffect.start_scale = 0.5 / 4
dyingEffect.fade_in_duration = 10
dyingEffect.fade_away_duration = 10

-- The small regular explosion for when the landmine detonates.
local dyingExplosion = Utils.DeepCopy(data.raw.explosion.explosion)
dyingExplosion.name = "stasis_min-stasis_dying_explosion"
dyingExplosion.animations = dyingExplosion.animations[1]
dyingExplosion.animations.shift = { 0, 1 }
dyingExplosion.animations.hr_version.shift = { 0, 1 }

data:extend(
    {
        targetEffect,
        sourceEffect,
        dyingEffect,
        dyingExplosion
    }
)
