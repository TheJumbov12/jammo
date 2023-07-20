if SERVER then
    AddCSLuaFile()
end

jlib = jlib or {}
jlib.PanelNotify = jlib.PanelNotify or {}

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = smallammoname
ENT.Author = "The Jumbo"
ENT.Spawnable = true
ENT.Category = "Jumbo Ammo"


function ENT:Initialize()
    if SERVER then
        self:SetModel(smallammomodel) 
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetCollisionGroup(1)

        self.usesLeft = smallammocount

    end
end



function ENT:Use(activator, caller)
    if not IsValid(caller) or not caller:IsPlayer() then return end
    
    local weapon = caller:GetActiveWeapon()
    if not IsValid(weapon) then return end

    local ammoType = weapon:GetPrimaryAmmoType()
    local ammoCount = weapon:GetMaxClip1()

    if self.usesLeft > 0 and ammoType ~= -1 and ammoCount > 0 then
        caller:GiveAmmo(ammoCount, ammoType)
        self.usesLeft = self.usesLeft - 1
        
        if self.usesLeft == 0 then
            self:Remove()
        end
    end
end
