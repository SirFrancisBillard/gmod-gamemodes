DEFINE_BASECLASS("player_citizen")

local PLAYER = {}

PLAYER.DisplayName = "Shooter"
PLAYER.WalkSpeed = 120
PLAYER.RunSpeed = 200

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()

	self.Player:Give("weapon_hands")
	self.Player:Give("weapon_pipebomb")
	self.Player:Give("shooter_deagle")
	self.Player:GiveAmmo(9999, "pistol", false)

	if math.random(3) == 1 then
		self.Player:Give("shooter_m3")
		self.Player:GiveAmmo(9999, "buckshot", false)
	else
		self.Player:Give("shooter_ak47")
		self.Player:GiveAmmo(9999, "smg1", false)
	end	
end

local ShooterModels = {"models/player/alyx.mdl", "models/player/eli.mdl", "models/player/p2_chell.mdl", "models/player/monk.mdl", "models/player/kleiner.mdl"}

function PLAYER:SetModel()
	local modelname = ShooterModels[math.random(#ShooterModels)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(1, 0, 0))
	self.Player:SetupHands()
end

function PLAYER:Spawn()
	self:SetModel()

	self.Player:SetWalkSpeed(self.WalkSpeed)
	self.Player:SetRunSpeed(self.RunSpeed)

	self.Player:SetMaxHealth(100)
	self.Player:SetHealth(100)
end


player_manager.RegisterClass("player_shooter", PLAYER, "player_citizen")
