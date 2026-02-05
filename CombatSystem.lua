--[[
	ZOMBIE GAME - COMBAT SYSTEM (LocalScript)
	Script de combate para el jugador
	Debe insertarse en StarterPlayer > StarterCharacterScripts
]]

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players:GetPlayerFromCharacter(script.Parent)
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- ============================================
-- CONFIGURACIÓN DE COMBATE
-- ============================================
local COMBAT_CONFIG = {
	AttackRange = 15,           -- Rango de ataque en studs
	AttackDamage = 25,          -- Daño por golpe
	AttackCooldown = 0.5,       -- Cooldown entre ataques (segundos)
	AttackAnimation = "Attack",
}

local LastAttackTime = 0
local IsAttacking = false

-- ============================================
-- CREAR HERRAMIENTA DE COMBATE
-- ============================================

local function CreateWeapon()
	local gun = Instance.new("Tool")
	gun.Name = "DefaultGun"
	gun.RequiresHandle = true
	
	local handle = Instance.new("Part")
	handle.Name = "Handle"
	handle.Shape = Enum.PartType.Block
	handle.Material = Enum.Material.Metal
	handle.BrickColor = BrickColor.new("Dark stone grey")
	handle.Size = Vector3.new(1, 0.5, 4)
	handle.CanCollide = false
	handle.Parent = gun
	
	gun.Parent = character
	return gun
end

-- Crear arma
local weapon = CreateWeapon()

-- ============================================
-- SISTEMA DE ATAQUE
-- ============================================

local function DealDamageToZombies()
	local zombiesHit = {}
	
	-- Buscar todos los zombis cerca
	for _, zombie in pairs(workspace:FindPartBoundsInRadius(rootPart.Position, COMBAT_CONFIG.AttackRange)) do
		if zombie:IsDescendantOf(workspace) and zombie.Name:match("Zombie_") then
			local zombieModel = zombie:FindFirstAncestorOfClass("Model")
			if zombieModel and not zombiesHit[zombieModel] then
				local zombieHumanoid = zombieModel:FindFirstChild("Humanoid")
				if zombieHumanoid then
					zombiesHit[zombieModel] = true
					zombieHumanoid:TakeDamage(COMBAT_CONFIG.AttackDamage)
					print("¡Golpe a " .. zombieModel.Name .. "! Daño: " .. COMBAT_CONFIG.AttackDamage)
				end
			end
		end
	end
	
	return next(zombiesHit) ~= nil
end

local function Attack()
	local currentTime = tick()
	
	-- Verificar cooldown
	if currentTime - LastAttackTime < COMBAT_CONFIG.AttackCooldown then
		return
	end
	
	if IsAttacking then
		return
	end
	
	LastAttackTime = currentTime
	IsAttacking = true
	
	-- Animación de ataque (simple)
	rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(10))
	
	-- Infligir daño a zombis cercanos
	DealDamageToZombies()
	
	-- Volver a posición normal
	task.wait(0.2)
	rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, 0, math.rad(-10))
	IsAttacking = false
end

-- ============================================
-- INPUT DE ATAQUE
-- ============================================

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	
	-- Click izquierdo o tecla E para atacar
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		Attack()
	elseif input.KeyCode == Enum.KeyCode.E then
		Attack()
	end
end)

-- ============================================
-- DETECCIÓN DE DAÑO AL JUGADOR
-- ============================================

humanoid.Touched:Connect(function(hit)
	if hit:IsDescendantOf(workspace) and hit.Name:match("Zombie_") then
		local zombieModel = hit:FindFirstAncestorOfClass("Model")
		if zombieModel then
			local zombieHumanoid = zombieModel:FindFirstChild("Humanoid")
			if zombieHumanoid and zombieHumanoid.Health > 0 then
				-- El zombi daña al jugador
				humanoid:TakeDamage(5)
				print(player.Name .. " fue atacado por " .. zombieModel.Name)
			end
		end
	end
end)

-- ============================================
-- MOSTRAR INFORMACIÓN EN PANTALLA
-- ============================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CombatUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Label de salud
local healthLabel = Instance.new("TextLabel")
healthLabel.Name = "HealthLabel"
healthLabel.Size = UDim2.new(0, 200, 0, 50)
healthLabel.Position = UDim2.new(0, 10, 0, 10)
healthLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
healthLabel.BackgroundTransparency = 0.5
healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
healthLabel.TextSize = 20
healthLabel.Font = Enum.Font.GothamBold
healthLabel.Parent = screenGui

-- Actualizar salud continuamente
humanoid.HealthChanged:Connect(function()
	healthLabel.Text = "❤️ Salud: " .. math.ceil(humanoid.Health) .. "/" .. math.ceil(humanoid.MaxHealth)
	
	-- Cambiar color si está bajo de salud
	if humanoid.Health < humanoid.MaxHealth / 3 then
		healthLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
	else
		healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	end
end)

-- Label de controles
local controlsLabel = Instance.new("TextLabel")
controlsLabel.Name = "ControlsLabel"
controlsLabel.Size = UDim2.new(0, 300, 0, 100)
controlsLabel.Position = UDim2.new(0, 10, 0.5, -50)
controlsLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
controlsLabel.BackgroundTransparency = 0.5
controlsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
controlsLabel.TextSize = 14
controlsLabel.Font = Enum.Font.Gotham
controlsLabel.TextWrapped = true
controlsLabel.Parent = screenGui

controlsLabel.Text = "CONTROLES:\n" ..
	"WASD - Moverse\n" ..
	"Click Izquierdo - Atacar\n" ..
	"E - Atacar (Alternativa)\n" ..
	"Espacio - Saltar"

-- ============================================
-- MENSAJE AL INICIAR
-- ============================================

print("═════════════════════════════════════════")
print("🎮 SISTEMA DE COMBATE INICIADO")
print("═════════════════════════════════════════")
print("✓ Sistema de ataque cargado")
print("✓ Rango de ataque: " .. COMBAT_CONFIG.AttackRange .. " studs")
print("✓ Daño por golpe: " .. COMBAT_CONFIG.AttackDamage)
print("✓ UI de combate disponible")
print("")
print("¡Mata zombis para ganar puntos!")
