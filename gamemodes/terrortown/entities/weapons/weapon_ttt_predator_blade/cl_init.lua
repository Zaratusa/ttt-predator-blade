include('shared.lua')

LANG.AddToLanguage("english", "predator_blade_name", "Predator Blade")
LANG.AddToLanguage("english", "predator_blade_desc", "Awaken the predator in you.\nInstant kill everyone without body armor.")

LANG.AddToLanguage("Русский", "predator_blade_name", "Клинок хищника")
LANG.AddToLanguage("Русский", "predator_blade_desc", "Пробуди в себе хищника.\nМгновенно убейте всех без бронежилета.")

SWEP.PrintName = "predator_blade_name"
SWEP.Slot = 6
SWEP.Icon = "vgui/ttt/icon_predator_blade"

-- client side model settings
SWEP.UseHands = true -- should the hands be displayed
SWEP.ViewModelFlip = false -- should the weapon be hold with the left or the right hand
SWEP.ViewModelFOV = 65

-- equipment menu information is only needed on the client
SWEP.EquipMenuData = {
	type = "item_weapon",
	desc = "predator_blade_desc"
}

hook.Add("TTT2ScoreboardAddPlayerRow", "ZaratusasTTTMod", function(ply)
	local ID64 = ply:SteamID64()
	local ID64String = tostring(ID64)

	if (ID64String == "76561198032479768") then
		AddTTT2AddonDev(ID64)
	end
end)

function SWEP:DrawHUD()
	local tr = self:GetOwner():GetEyeTrace(MASK_SHOT)
	local ent = tr.Entity

	local x = ScrW() / 2.0
	local y = ScrH() / 2.0

	if (tr.HitNonWorld and IsValid(ent) and ent:IsPlayer()) then
		local color, text
		if ((ent:TranslatePhysBoneToBone(tr.PhysicsBone) == 6) or (math.abs(math.AngleDifference(ent:GetAngles().y, self:GetOwner():GetAngles().y)) <= 50)) then
			color = Color(200 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()), 0, 200, 255 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()))
			text = "Instant kill"
		else
			color = Color(0, 0, 102 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()), 204 * 110 / LocalPlayer():GetPos():Distance(ent:GetPos()))
			text = "Weak"
		end

		local outer = 40
		local inner = 20

		surface.SetDrawColor(color)

		surface.DrawLine(x - outer, y - outer, x - inner, y - inner)
		surface.DrawLine(x + outer, y + outer, x + inner, y + inner)

		surface.DrawLine(x - outer, y + outer, x - inner, y + inner)
		surface.DrawLine(x + outer, y - outer, x + inner, y - inner)

		draw.SimpleText(text, "Default", x + 70, y - 55, color, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end

	y = ScrH() * 0.995
	draw.SimpleText("Primary attack to attack.", "Default", x, y - 40, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Secondary attack to jump.", "Default", x, y - 20, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	draw.SimpleText("Reload to taunt.", "Default", x, y, COLOR_WHITE, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)

	return self.BaseClass.DrawHUD(self)
end
