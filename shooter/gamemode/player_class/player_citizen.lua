DEFINE_BASECLASS("player_default")

local PLAYER = {}

PLAYER.DisplayName = "Citizen"
PLAYER.WalkSpeed = 120
PLAYER.RunSpeed = 200

CLASS_EMO = 1
CLASS_FATASS = 2
CLASS_VIRGIN = 3
CLASS_THOT = 4
CLASS_BLACK = 5
CLASS_MAX = CLASS_BLACK

gCitizenClasses = {
	[CLASS_EMO] = {
		models = {"models/player/p2_chell.mdl"},
		weps = {"weapon_selfharm"},
		health = 80,
	},
	[CLASS_FATASS] = {
		models = {"models/player/monk.mdl"},
		weps = {"weapon_eatfood"},
		speeds = {90, 170},
		health = 160,
	},
	[CLASS_VIRGIN] = {
		models = {"models/player/kleiner.mdl"},
		weps = {"weapon_guitar"},
	},
	[CLASS_THOT] = {
		models = {"models/player/alyx.mdl"},
		weps = {"weapon_thotphone"},
	},
	[CLASS_BLACK] = {
		models = {"models/player/eli.mdl"},
		weps = {"weapon_lean"},
		speeds = {130, 210},
	},
}

function PLAYER:Loadout()
	self.Player:StripWeapons()
	self.Player:RemoveAllAmmo()
	self.Player:Give("weapon_hands")
	for i, v in ipairs(gCitizenClasses[self.Player:GetSpecialClass()].weps) do
		self.Player:Give(v)
	end
end

function PLAYER:SetupDataTables()
	self.Player:NetworkVar("Int", 0, "SpecialClass")
end

function PLAYER:SetModel(cls)
	local modelname = gCitizenClasses[cls].models[math.random(#gCitizenClasses[cls].models)]
	util.PrecacheModel(modelname)
	self.Player:SetModel(modelname)
	self.Player:SetPlayerColor(Vector(math.random(2) - 1, math.random(2) - 1, math.random(2) - 1))
	self.Player:SetupHands()
end

function PLAYER:Spawn()
	local cls = math.random(CLASS_MAX)
	self.Player:SetSpecialClass(cls)
	self:SetModel(cls)

	if gCitizenClasses[cls].speeds then
		self.Player:SetWalkSpeed(gCitizenClasses[cls].speeds[1])
		self.Player:SetRunSpeed(gCitizenClasses[cls].speeds[2])
	else
		self.Player:SetWalkSpeed(self.WalkSpeed)
		self.Player:SetRunSpeed(self.RunSpeed)
	end

	if gCitizenClasses[cls].health then
		self.Player:SetMaxHealth(gCitizenClasses[cls].health)
		self.Player:SetHealth(gCitizenClasses[cls].health)
	else
		self.Player:SetMaxHealth(100)
		self.Player:SetHealth(100)
	end
end

player_manager.RegisterClass("player_citizen", PLAYER, "player_default")
