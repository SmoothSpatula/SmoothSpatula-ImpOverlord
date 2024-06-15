log.info("Successfully loaded ".._ENV["!guid"]..".")
survivor_setup = require("./survivor_setup")
mods.on_all_mods_loaded(function() for k, v in pairs(mods) do if type(v) == "table" and v.hfuncs then Helper = v end end end)

-- ========== Sprite ========== 

-- local portrait_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanPortrait.png")
-- local portraitsmall_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanPortraitSmall.png")

-- Using a modified version of https://elthen.itch.io/2d-pixel-art-portal-sprites as a placeholder
-- local special_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites","PurplePortalSpriteSheet192x96.png")
-- local ball_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites","sCandymanBall.png")

local skills_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "skillsicons.png")
-- local loadout_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanLoadout.png")
-- local idle_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanIdle.png")
-- local walk_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanWalk.png")
-- local shoot1_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot1.png")
-- local shoot1_air_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot1Air.png")
-- local shoot2_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanShoot2.png")
-- local death_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanDeath.png")
-- local jump_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanjump.png")
-- local jumpfall_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanjumpfall.png")
-- local hit_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "sCandymanhit.png")

-- local palette_path = path.combine(_ENV["!plugins_mod_folder_path"], "Sprites", "candyman_PAL.png")


-- local portrait_sprite = gm.sprite_add(portrait_path, 1, false, false, 0, 0)
-- local portraitsmall_sprite = gm.sprite_add(portraitsmall_path, 1, false, false, 0, 0)
local skills_sprite = gm.sprite_add(skills_path, 4, false, false, 0, 0)
-- local loadout_sprite = gm.sprite_add(loadout_path, 7, false, false, 100, 5)
local idle_sprite = gm.sprite_duplicate(812)
local walk_sprite = gm.sprite_duplicate(814)
local attack_sprite = gm.sprite_duplicate(818)
-- local shoot1_air_sprite = gm.sprite_add(shoot1_air_path, 7, false, false, 29, 45)
local utility_sprite = gm.sprite_duplicate(822)
local secondary_sprite = gm.sprite_duplicate(823)
local special_sprite = gm.sprite_duplicate(826)
-- local jump_sprite = gm.sprite_add(jump_path, 1, false, false, 29, 45)
-- local jumpfall_sprite = gm.sprite_add(jumpfall_path, 1, false, false, 29, 45)
-- local hit_sprite = gm.sprite_add(hit_path, 1, false, false, 29, 45)


-- local palette_sprite = gm.sprite_add(hit_path, 1, false, false, 0, 0)

gm.sprite_set_offset(idle_sprite, 70, 107)
gm.sprite_set_speed(idle_sprite, 1, 1)
gm.sprite_set_offset(attack_sprite, 50, 113)
gm.sprite_set_speed(attack_sprite, 1, 1)
gm.sprite_set_offset(walk_sprite, 70, 95)
gm.sprite_set_speed(walk_sprite, 1, 1)
gm.sprite_set_offset(utility_sprite, 38, 100)
gm.sprite_set_speed(utility_sprite, 1, 1)
gm.sprite_set_offset(secondary_sprite, 50, 113)
gm.sprite_set_speed(secondary_sprite, 1, 1)
gm.sprite_set_offset(special_sprite, 50, 110)
gm.sprite_set_speed(special_sprite, 1, 1)

print(empty_sprite)

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
    ImpOverlord.sprite_title = walk_sprite
    ImpOverlord.sprite_idle = idle_sprite
    ImpOverlord.sprite_portrait = 722
    ImpOverlord.sprite_portrait_small = 722
    ImpOverlord.sprite_palette = 830
    ImpOverlord.sprite_portrait_palette = 830
    ImpOverlord.sprite_loadout_palette = 830
    ImpOverlord.sprite_credits = walk_sprite

    -- Configure Skills

    local skills = gm.variable_global_get("class_skill")

    -- Primary
    local skill_primary = ImpOverlord.skill_family_z[0]
    skill_primary.token_name = "Candy Smash"
    skill_primary.token_description = "Smash ennemies for <y>150% damage.</c>\n Smash <b>all</c> the balls in its range."

    skill_primary.sprite = skills_sprite
    skill_primary.subimage = 0

    skill_primary.animation = attack_sprite

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

    skill_secondary.animation = secondary_sprite
    

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

    skill_utility.animation = utility_sprite

    skill_utility.cooldown = 30
    skill_utility.damage = 1.5
    skill_utility.required_stock = 1
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

    skill_special.animation = special_sprite

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

local function setup_sprites(self, invis_sprite)
    local survivors = gm.variable_global_get("class_survivor")

    if not survivors or self.class ~= ImpOverlord_id then return end

    self.sprite_idle        = idle_sprite
    self.sprite_walk        = walk_sprite
    self.sprite_jump        = idle_sprite
    self.sprite_jump_peak   = idle_sprite
    self.sprite_fall        = idle_sprite
    self.sprite_climb       = idle_sprite
    self.sprite_death       = 841
    self.sprite_decoy       = 828
end

local func_explode =  function (self)
    gm._mod_attack_fire_explosion(
        self,
        self.x,
        self.y,
        60,
        35,
        self.skills[1].active_skill.damage,
        gm.constants.sEfBloodExplosion,
        gm.constants.sSparks1,
        true)
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
    if callback_id == ImpOverlord.skill_family_z[0].on_activate then
        -- do better hit
        func_explode(self)
        local _handle = gm.call_later(20, 1, gm.constants.function_dummy, false)
        local _handle2 = gm.call_later(40, 1, gm.constants.function_dummy, false)
    end

    if callback_id == ImpOverlord.skill_family_c[0].on_activate then
        -- do better spawn
        local inst = gm.instance_create_depth(self.x, self.y, self.layer, gm.constants["oImpFriend"])
    end
end)

gm.post_script_hook(gm.constants.stage_load_room, function(self, other, result, args)
    if not is_init then 
        is_init = true
        create_survivor() end
end)

gm.post_script_hook(gm.constants.function_dummy, function(self, other, result, args)
    func_explode(Helper.get_client_player())
end)

gm.post_script_hook(gm.constants.texture_flush_group, function()
    local Imps = Helper.find_active_instance_all(gm.constants.oImpFriend)
    for _, imp in ipairs(Imps) do
        gm.instance_destroy(imp)
    end
end)
