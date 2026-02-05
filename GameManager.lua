--[[
	ZOMBIE GAME - GAME MANAGER
	Sistema de gestión del juego de zombis
	Maneja: Oleadas, contadores, y lógica general
]]

local GameManager = {}

-- CONFIGURACIÓN DEL JUEGO
GameManager.Config = {
	WaveDelay = 30,              -- Segundos entre oleadas
	InitialZombieCount = 3,      -- Zombis en la primera oleada
	ZombieIncrement = 2,         -- Zombis adicionales por oleada
	MaxZombies = 50,             -- Máximo de zombis simultáneos
	ZombieHealth = 50,           -- Vida de cada zombi
	ZombieSpeed = 25,            -- Velocidad de movimiento
	KillReward = 25,             -- Dinero/puntos por matar zombi
}

-- REFERENCIAS
GameManager.Resources = {
	PlayersData = {},
	CurrentWave = 0,
	ActiveZombies = 0,
	MaxWaveZombies = GameManager.Config.InitialZombieCount
}

-- ============================================
-- FUNCIONES DE UTILIDAD
-- ============================================

-- Obtener todos los jugadores
function GameManager:GetAllPlayers()
	return game:GetService("Players"):GetPlayers()
end

-- Crear moneda/dinero para jugador
function GameManager:GivePlayerMoney(player, amount)
	if not self.Resources.PlayersData[player] then
		self.Resources.PlayersData[player] = {
			Money = 0,
			Kills = 0,
			Deaths = 0
		}
	end
	self.Resources.PlayersData[player].Money = self.Resources.PlayersData[player].Money + amount
	print(player.Name .. " gana " .. amount .. " dinero")
end

-- ============================================
-- SISTEMA DE OLEADAS
-- ============================================

function GameManager:StartNewWave()
	self.Resources.CurrentWave = self.Resources.CurrentWave + 1
	self.Resources.MaxWaveZombies = self.Config.InitialZombieCount + 
		(self.Resources.CurrentWave - 1) * self.Config.ZombieIncrement
	
	-- Limitar máximo de zombis
	if self.Resources.MaxWaveZombies > self.Config.MaxZombies then
		self.Resources.MaxWaveZombies = self.Config.MaxZombies
	end
	
	print("╔════════════════════════════════╗")
	print("  ONDA " .. self.Resources.CurrentWave .. " INICIADA")
	print("  Zombis: " .. self.Resources.MaxWaveZombies)
	print("╚════════════════════════════════╝")
	
	-- Comenzar a spawnear zombis
	self:SpawnZombiesForWave()
end

function GameManager:SpawnZombiesForWave()
	local spawner = workspace:FindFirstChild("ZombieSpawner")
	if not spawner then 
		warn("ZombieSpawner no encontrado")
		return 
	end
	
	for i = 1, self.Resources.MaxWaveZombies do
		task.wait(1) -- Delay entre spawns
		self:SpawnZombie(spawner.Position)
	end
end

function GameManager:SpawnZombie(position)
	-- Crear modelo de zombi simple
	local zombie = Instance.new("Model")
	zombie.Name = "Zombie_" .. self.Resources.CurrentWave .. "_" .. self.Resources.ActiveZombies
	
	-- Cuerpo
	local humanoidRootPart = Instance.new("Part")
	humanoidRootPart.Name = "HumanoidRootPart"
	humanoidRootPart.Shape = Enum.PartType.Block
	humanoidRootPart.Material = Enum.Material.SmoothPlastic
	humanoidRootPart.BrickColor = BrickColor.new("Bright green")
	humanoidRootPart.Size = Vector3.new(2, 3, 1)
	humanoidRootPart.CanCollide = true
	humanoidRootPart.CFrame = CFrame.new(position + Vector3.new(0, 5, 0))
	humanoidRootPart.Parent = zombie
	
	-- Cabeza
	local head = Instance.new("Part")
	head.Name = "Head"
	head.Shape = Enum.PartType.Ball
	head.Material = Enum.Material.SmoothPlastic
	head.BrickColor = BrickColor.new("Bright green")
	head.Size = Vector3.new(1.5, 1.5, 1.5)
	head.CanCollide = true
	head.CFrame = CFrame.new(position + Vector3.new(0, 6.5, 0))
	head.Parent = zombie
	
	-- Humanoid
	local humanoid = Instance.new("Humanoid")
	humanoid.Parent = zombie
	humanoid.MaxHealth = self.Config.ZombieHealth
	humanoid.Health = self.Config.ZombieHealth
	
	-- Weld (conectar partes)
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = humanoidRootPart
	weld.Part1 = head
	weld.Parent = zombie
	
	-- Set en workspace
	zombie.Parent = workspace
	
	-- Manejar muerte del zombi
	humanoid.Died:Connect(function()
		self.Resources.ActiveZombies = self.Resources.ActiveZombies - 1
		if zombie:IsDescendantOf(workspace) then
			zombie:Destroy()
		end
		print("Zombi eliminado. Activos: " .. self.Resources.ActiveZombies)
	end)
	
	self.Resources.ActiveZombies = self.Resources.ActiveZombies + 1
	
	-- Script simple de IA (perseguir al jugador más cercano)
	task.spawn(function()
		while zombie:IsDescendantOf(workspace) and humanoid.Health > 0 do
			local players = self:GetAllPlayers()
			local nearestPlayer = nil
			local nearestDistance = math.huge
			
			for _, player in pairs(players) do
				if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					local distance = (humanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
					if distance < nearestDistance then
						nearestDistance = distance
						nearestPlayer = player
					end
				end
			end
			
			-- Perseguir si hay un jugador cerca
			if nearestPlayer and nearestPlayer.Character then
				local targetPos = nearestPlayer.Character.HumanoidRootPart.Position
				local direction = (targetPos - humanoidRootPart.Position).Unit
				
				-- Aplicar velocidad de movimiento
				humanoidRootPart.Velocity = direction * self.Config.ZombieSpeed + Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
				
				-- Atacar si está muy cerca
				if nearestDistance < 5 then
					humanoid:MoveTo(targetPos)
					-- Aquí iría el código de daño al jugador
				end
			end
			
			task.wait(0.1)
		end
	end)
end

-- ============================================
-- LOOP PRINCIPAL DEL JUEGO
-- ============================================

function GameManager:Start()
	print("═══════════════════════════════════════")
	print("  ZOMBIE GAME INICIADO")
	print("═══════════════════════════════════════")
	
	-- Primero esperar a que los jugadores carguen
	task.wait(5)
	
	-- Loop de oleadas
	while true do
		self:StartNewWave()
		
		-- Esperar a que terminen todos los zombis o 60 segundos
		local waveStartTime = tick()
		while self.Resources.ActiveZombies > 0 and (tick() - waveStartTime) < 60 do
			task.wait(1)
		end
		
		print("Onda " .. self.Resources.CurrentWave .. " completada")
		task.wait(self.Config.WaveDelay)
	end
end

-- ============================================
-- INICIAR GAME MANAGER
-- ============================================

-- Esperar a que el mapa esté listo
task.wait(2)

-- Iniciar el juego
GameManager:Start()

return GameManager
