log.info("Successfully loaded ".._ENV["!guid"]..".")
survivor_setup = require("./survivor_setup")
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.hfuncs then Helper = v end end end)

-- ========== Sprite ========== 

local portrait_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanPortrait.png")
local portraitsmall_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanPortraitSmall.png")

-- Using a modified version of https://elthen.itch.io/2d-pixel-art-portal-sprites as a placeholder
local special_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites","PurplePortalSpriteSheet192x96.png")
local ball_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites","sCandymanBall.png")

local skills_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "skillsicons.png")
local loadout_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanLoadout.png")
local idle_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanIdle.png")
local walk_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanWalk.png")
local shoot1_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot1.png")
local shoot1_air_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot1Air.png")
local shoot2_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot2.png")
local death_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanDeath.png")
local jump_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanjump.png")
local jumpfall_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanjumpfall.png")
local hit_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanhit.png")
local empty_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanEmpty.png")

local palette_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "candyman_PAL.png")


local portrait_sprite = gm.sprite_add(portrait_path, 1, false, false, 0, 0)
local portraitsmall_sprite = gm.sprite_add(portraitsmall_path, 1, false, false, 0, 0)

local special_sprite = gm.sprite_add(special_path, 8, false, false, 48, 105)
local ball_sprite = gm.sprite_add(ball_path, 6, false, false, 14, 14)

local skills_sprite = gm.sprite_add(skills_path, 4, false, false, 0, 0)
local loadout_sprite = gm.sprite_add(loadout_path, 7, false, false, 100, 5)
local idle_sprite = gm.sprite_add(idle_path, 3, false, false, 29, 45)
local walk_sprite = gm.sprite_add(walk_path, 2, false, false, 29, 45)
local shoot1_sprite = gm.sprite_add(shoot1_path, 7, false, false, 29, 45)
local shoot1_air_sprite = gm.sprite_add(shoot1_air_path, 7, false, false, 29, 45)
local shoot2_sprite = gm.sprite_add(shoot2_path, 4, false, false, 29, 45)
local death_sprite = gm.sprite_add(death_path, 4, false, false, 29, 10)
local jump_sprite = gm.sprite_add(jump_path, 1, false, false, 29, 45)
local jumpfall_sprite = gm.sprite_add(jumpfall_path, 1, false, false, 29, 45)
local hit_sprite = gm.sprite_add(hit_path, 1, false, false, 29, 45)
local empty_sprite = gm.sprite_add(empty_path, 1, false, false, 0, 0)

local palette_sprite = gm.sprite_add(hit_path, 1, false, false, 0, 0)


-- ========== Survivor Setup ==========

local ImpOverlord_id = -1
local ImpOverlord = nil
local is_init = false



local function create_survivor()
    ImpOverlord_id = gm.survivor_create("SmoothSpatula", "ImpOverlord")
    ImpOverlord = survivor_setup.Survivor(ImpOverlord_id)

    -- Configure Properties
    ImpOverlord.token_name = "ImpOverlord"
    ImpOverlord.token_name_upper = "ImpOverlord"
    ImpOverlord.token_description = "<y>ImpOverlord<w> has had enough of dying to the countless survivors invading his home, it is time for him to join the battle."
    ImpOverlord.token_end_quote = "..."

    ImpOverlord.sprite_loadout = 832
    ImpOverlord.sprite_title = 814
    ImpOverlord.sprite_idle = 812
    ImpOverlord.sprite_portrait = 722
    ImpOverlord.sprite_portrait_small = 722
    ImpOverlord.sprite_palette = 830
    ImpOverlord.sprite_portrait_palette = palette_sprite
    ImpOverlord.sprite_loadout_palette = palette_sprite
    ImpOverlord.sprite_credits = 814

    -- Configure Skills

    local skills = gm.variable_global_get("class_skill")

    -- Primary
    local skill_primary = ImpOverlord.skill_family_z[0]
    skill_primary.token_name = "Candy Smash"
    skill_primary.token_description = "Smash ennemies for <y>150% damage.</c>\n Smash <b>all</c> the balls in its range."

    skill_primary.sprite = skills_sprite
    skill_primary.subimage = 0

    skill_primary.animation = skills[170][16]

    skill_primary.cooldown = 0
    skill_primary.damage = 1.5
    skill_primary.required_stock = 0
    skill_primary.require_key_press = true
    skill_primary.use_delay = 0
    skill_primary.is_primary = true

    skill_primary.does_change_activity_state = true

    skill_primary.on_can_activate = skills[170][25]
    skill_primary.on_activate = skills[170][26]
    -- -- Secondary
    local skill_secondary = ImpOverlord.skill_family_x[0]
    skill_secondary.token_name = "Candy Smash 2"
    skill_secondary.token_description = "Smash ennemies for <y>150% damage.</c>\n Smash <b>all</c> the balls in its range."

    skill_secondary.sprite = skills_sprite
    skill_secondary.subimage = 1

    skill_secondary.animation = skills[172][16]

    skill_secondary.cooldown = 0
    skill_secondary.damage = 1.5
    skill_secondary.required_stock = 0
    skill_secondary.require_key_press = true
    skill_secondary.use_delay = 0
    skill_secondary.is_primary = false

    skill_secondary.does_change_activity_state = true

    skill_secondary.on_can_activate = skills[172][25]
    skill_secondary.on_activate = skills[172][26]
    
    -- -- Utility
    local skill_utility = ImpOverlord.skill_family_c[0]
    skill_utility.token_name = "Candy Smash 2"
    skill_utility.token_description = "Smash ennemies for <y>150% damage.</c>\n Smash <b>all</c> the balls in its range."

    skill_utility.sprite = skills_sprite
    skill_utility.subimage = 2

    skill_utility.animation = skills[173][16]

    skill_utility.cooldown = 0
    skill_utility.damage = 1.5
    skill_utility.required_stock = 0
    skill_utility.require_key_press = true
    skill_utility.use_delay = 0
    skill_utility.is_primary = false

    skill_utility.does_change_activity_state = true

    skill_utility.on_can_activate = skills[173][25]
    skill_utility.on_activate = skills[173][26]

    
    -- -- Special
    local skill_special = ImpOverlord.skill_family_v[0]
    skill_special.token_name = "Candy Smash 2"
    skill_special.token_description = "Smash ennemies for <y>150% damage.</c>\n Smash <b>all</c> the balls in its range."

    skill_special.sprite = skills_sprite
    skill_special.subimage = 3

    skill_special.animation = skills[174][16]

    skill_special.cooldown = 0
    skill_special.damage = 1.5
    skill_special.required_stock = 0
    skill_special.require_key_press = true
    skill_special.use_delay = 0
    skill_special.is_primary = false

    skill_special.does_change_activity_state = true

    skill_special.on_can_activate = skills[174][25]
    skill_special.on_activate = skills[174][26]


end

--create_survivor()

local function setup_sprites(self)
    local survivors = gm.variable_global_get("class_survivor")

    if not survivors or self.class ~= ImpOverlord_id then return end

    self.sprite_idle        = 812
    self.sprite_walk        = 814
    self.sprite_jump        = 812
    self.sprite_jump_peak   = 812
    self.sprite_fall        = 812
    self.sprite_climb       = 812
    self.sprite_death       = 828
    self.sprite_decoy       = 828
end


-- Init callback
local callback_names = gm.variable_global_get("callback_names")
local on_player_init_callback_id = 0
for i = 1, #callback_names do
    local callback_name = callback_names[i]
    if callback_name:match("onPlayerInit") then
        on_player_init_callback_id = i - 1
    end
end

gm.post_script_hook(gm.constants.callback_execute, function(self, other, result, args)
    if self.class ~= ImpOverlord_id then return end

    local callback_id = args[1].value
    if callback_id == on_player_init_callback_id then
        setup_sprites(self)
    end
end)

gm.post_script_hook(gm.constants.stage_load_room, function(self, other, result, args)
    if not is_init then 
        print("test")
        is_init = true
        create_survivor() end
end)