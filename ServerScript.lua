--[[
	ZOMBIE GAME - SERVIDOR COMPLETO
	Generador de mapa + Sistema de oleadas de zombis
	
	INSTALACIÓN:
	1. Paste este script en ServerScriptService
	2. ¡Listo! Todo funciona automáticamente
]]

local Terrain = workspace.Terrain

-- ============================================
-- CONFIGURACIÓN GENERAL
-- ============================================
local MAP_SIZE = 256
local TERRAIN_HEIGHT = 10

-- Configuración del juego de zombis
local GAME_CONFIG = {
	WaveDelay = 30,
	InitialZombieCount = 3,
	ZombieIncrement = 2,
	MaxZombies = 50,
	ZombieHealth = 50,
	ZombieSpeed = 25,
	KillReward = 25,
}

local GameState = {
	PlayersData = {},
	CurrentWave = 0,
	ActiveZombies = 0,
	MaxWaveZombies = GAME_CONFIG.InitialZombieCount,
	GameStarted = false,
}

-- Limpiar terreno existente
Terrain:Clear()

-- ============================================
-- 1. GENERAR TERRENO DE HIERBA
-- ============================================
local grassRegion = Region3.new(
	Vector3.new(-MAP_SIZE, 0, -MAP_SIZE),
	Vector3.new(MAP_SIZE, TERRAIN_HEIGHT, MAP_SIZE)
)
grassRegion = grassRegion:ExpandToGrid(4)
Terrain:FillBall(Vector3.new(0, TERRAIN_HEIGHT/2, 0), MAP_SIZE * 1.2, Enum.Material.Grass)

print("✓ Terreno de hierba generado")

-- ============================================
-- 2. GENERAR CALLES
-- ============================================
local function createStreet(startPos, endPos, width)
	local direction = (endPos - startPos).Unit
	local distance = (endPos - startPos).Magnitude
	local midPoint = startPos + direction * (distance / 2)
	
	local street = Instance.new("Part")
	street.Name = "Street"
	street.Shape = Enum.PartType.Block
	street.Material = Enum.Material.Concrete
	street.BrickColor = BrickColor.new("Dark stone grey")
	street.Size = Vector3.new(width, 0.5, distance + 5)
	street.TopSurface = Enum.SurfaceType.Smooth
	street.BottomSurface = Enum.SurfaceType.Smooth
	street.CFrame = CFrame.new(midPoint + Vector3.new(0, TERRAIN_HEIGHT + 0.25, 0))
	
	-- Calcular rotación correcta
	street.CFrame = street.CFrame * CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.atan2(direction.X, direction.Z))
	
	street.CanCollide = true
	street.Parent = workspace
	return street
end

-- Crear calles principales (en forma de cruz)
local streetWidth = 20

-- Calle horizontal (Este-Oeste)
createStreet(
	Vector3.new(-MAP_SIZE, 0, 0),
	Vector3.new(MAP_SIZE, 0, 0),
	streetWidth
)

-- Calle vertical (Norte-Sur)
createStreet(
	Vector3.new(0, 0, -MAP_SIZE),
	Vector3.new(0, 0, MAP_SIZE),
	streetWidth
)

-- Calles secundarias (formando una malla)
local secondaryStreetSpacing = 80

for i = -1, 1 do
	if i ~= 0 then
		-- Calles horizontales
		createStreet(
			Vector3.new(-MAP_SIZE, 0, i * secondaryStreetSpacing),
			Vector3.new(MAP_SIZE, 0, i * secondaryStreetSpacing),
			12
		)
		
		-- Calles verticales
		createStreet(
			Vector3.new(i * secondaryStreetSpacing, 0, -MAP_SIZE),
			Vector3.new(i * secondaryStreetSpacing, 0, MAP_SIZE),
			12
		)
	end
end

print("✓ Calles generadas")

-- ============================================
-- 3. FUNCIÓN PARA CREAR EDIFICIOS
-- ============================================
local function createBuilding(position, size, color, name)
	local building = Instance.new("Part")
	building.Name = name or "Building"
	building.Shape = Enum.PartType.Block
	building.Material = Enum.Material.Brick
	building.BrickColor = BrickColor.new(color)
	building.Size = size
	building.CanCollide = true
	building.CFrame = CFrame.new(position)
	building.TopSurface = Enum.SurfaceType.Smooth
	building.BottomSurface = Enum.SurfaceType.Smooth
	building.Parent = workspace
	
	-- Agregar techo
	local roof = Instance.new("Part")
	roof.Name = "Roof"
	roof.Shape = Enum.PartType.Block
	roof.Material = Enum.Material.Slate
	roof.BrickColor = BrickColor.new("Dark stone grey")
	roof.Size = Vector3.new(size.X, 2, size.Z)
	roof.CanCollide = true
	roof.CFrame = CFrame.new(position + Vector3.new(0, size.Y/2 + 1, 0))
	roof.TopSurface = Enum.SurfaceType.Smooth
	roof.BottomSurface = Enum.SurfaceType.Smooth
	roof.Parent = workspace
	
	return building
end

-- ============================================
-- 4. CREAR EDIFICIOS EN LAS ESQUINAS
-- ============================================
local buildingSize = 40
local cornerDistance = MAP_SIZE - 30

-- Esquina Noreste
createBuilding(
	Vector3.new(cornerDistance, TERRAIN_HEIGHT + buildingSize/2, -cornerDistance),
	Vector3.new(buildingSize, buildingSize, buildingSize),
	"Dark stone grey",
	"Building_NE"
)

-- Esquina Noroeste
createBuilding(
	Vector3.new(-cornerDistance, TERRAIN_HEIGHT + buildingSize/2, -cornerDistance),
	Vector3.new(buildingSize, buildingSize, buildingSize),
	"Brown",
	"Building_NW"
)

-- Esquina Sureste
createBuilding(
	Vector3.new(cornerDistance, TERRAIN_HEIGHT + buildingSize/2, cornerDistance),
	Vector3.new(buildingSize, buildingSize, buildingSize),
	"Dark stone grey",
	"Building_SE"
)

-- Esquina Suroeste
createBuilding(
	Vector3.new(-cornerDistance, TERRAIN_HEIGHT + buildingSize/2, cornerDistance),
	Vector3.new(buildingSize, buildingSize, buildingSize),
	"Brown",
	"Building_SW"
)

print("✓ Edificios en esquinas generados")

-- ============================================
-- 5. CREAR EDIFICIOS MEDIANOS EN POSICIONES INTERMEDIAS
-- ============================================
local mediumBuildingSize = 30

-- Espacios intermedios (norte, sur, este, oeste)
local positions = {
	Vector3.new(cornerDistance, TERRAIN_HEIGHT + mediumBuildingSize/2, 0),  -- Este
	Vector3.new(-cornerDistance, TERRAIN_HEIGHT + mediumBuildingSize/2, 0), -- Oeste
	Vector3.new(0, TERRAIN_HEIGHT + mediumBuildingSize/2, -cornerDistance),  -- Norte
	Vector3.new(0, TERRAIN_HEIGHT + mediumBuildingSize/2, cornerDistance)    -- Sur
}

local colors = {"Bright red", "Dark stone grey", "Brown", "Bright red"}
local names = {"Building_E", "Building_W", "Building_N", "Building_S"}

for i, pos in ipairs(positions) do
	createBuilding(
		pos,
		Vector3.new(mediumBuildingSize, mediumBuildingSize, mediumBuildingSize),
		colors[i],
		names[i]
	)
end

print("✓ Edificios intermedios generados")

-- ============================================
-- 6. AGREGAR DETALLES (Árboles pequeños como decoración)
-- ============================================
local function createTree(position)
	-- Tronco
	local trunk = Instance.new("Part")
	trunk.Name = "TreeTrunk"
	trunk.Shape = Enum.PartType.Cylinder
	trunk.Material = Enum.Material.Wood
	trunk.BrickColor = BrickColor.new("Reddish brown")
	trunk.Size = Vector3.new(3, 15, 3)
	trunk.CanCollide = true
	trunk.CFrame = CFrame.new(position + Vector3.new(0, TERRAIN_HEIGHT + 7, 0)) * CFrame.Angles(math.pi/2, 0, 0)
	trunk.Parent = workspace
	
	-- Copa
	local crown = Instance.new("Part")
	crown.Name = "TreeCrown"
	crown.Shape = Enum.PartType.Ball
	crown.Material = Enum.Material.Grass
	crown.BrickColor = BrickColor.new("Dark green")
	crown.Size = Vector3.new(20, 20, 20)
	crown.CanCollide = false
	crown.CFrame = CFrame.new(position + Vector3.new(0, TERRAIN_HEIGHT + 18, 0))
	crown.Parent = workspace
end

-- Plantar árboles en áreas de paisaje
local treePositions = {
	Vector3.new(-150, 0, -150),
	Vector3.new(150, 0, -150),
	Vector3.new(-150, 0, 150),
	Vector3.new(150, 0, 150),
	Vector3.new(-100, 0, 0),
	Vector3.new(100, 0, 0),
	Vector3.new(0, 0, -100),
	Vector3.new(0, 0, 100),
	Vector3.new(-80, 0, -80),
	Vector3.new(80, 0, 80),
}

for _, treePos in ipairs(treePositions) do
	createTree(treePos)
end

print("✓ Árboles decorativos plantados")

-- ============================================
-- 7. REMOVER BASEPLATE EXISTENTE
-- ============================================
local baseplate = workspace:FindFirstChild("Baseplate")
if baseplate then
	baseplate:Destroy()
	print("✓ Baseplate removido")
end

-- ============================================
-- 8. CREAR SPAWN POINT PARA JUGADORES
-- ============================================
local spawnPart = Instance.new("Part")
spawnPart.Name = "SpawnPart"
spawnPart.Shape = Enum.PartType.Block
spawnPart.Material = Enum.Material.Neon
spawnPart.BrickColor = BrickColor.new("Bright green")
spawnPart.Size = Vector3.new(20, 1, 20)
spawnPart.CanCollide = false
spawnPart.CFrame = CFrame.new(Vector3.new(0, TERRAIN_HEIGHT + 5, 0))
spawnPart.Parent = workspace

print("✓ Punto de spawn creado")

-- ============================================
-- 9. CREAR ZONA DE ZOMBIS (SPAWNER)
-- ============================================
local zombieSpawnerPart = Instance.new("Part")
zombieSpawnerPart.Name = "ZombieSpawner"
zombieSpawnerPart.Shape = Enum.PartType.Block
zombieSpawnerPart.Material = Enum.Material.Neon
zombieSpawnerPart.BrickColor = BrickColor.new("Bright red")
zombieSpawnerPart.Size = Vector3.new(40, 1, 40)
zombieSpawnerPart.CanCollide = false
zombieSpawnerPart.CFrame = CFrame.new(Vector3.new(cornerDistance - 20, TERRAIN_HEIGHT + 1, cornerDistance - 20))
zombieSpawnerPart.Parent = workspace

print("✓ Área de spawn de zombis creada (zona Sureste)")

-- ============================================
-- FINALIZACIÓN DEL MAPA
-- ============================================
print("╔══════════════════════════════════════╗")
print("║  MAPA DE ZOMBIS GENERADO EXITOSAMENTE  ║")
print("╚══════════════════════════════════════╝")

-- ============================================
-- PARTE 2: SISTEMA DE OLEADAS (GameManager)
-- ============================================

local function GivePlayerMoney(player, amount)
	if not GameState.PlayersData[player] then
		GameState.PlayersData[player] = {
			Money = 0,
			Kills = 0,
			Deaths = 0
		}
	end
	GameState.PlayersData[player].Money = GameState.PlayersData[player].Money + amount
end

local function GetAllPlayers()
	return game:GetService("Players"):GetPlayers()
end

local function SpawnZombie(position)
	local zombie = Instance.new("Model")
	zombie.Name = "Zombie_" .. GameState.CurrentWave .. "_" .. GameState.ActiveZombies
	
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
	humanoid.MaxHealth = GAME_CONFIG.ZombieHealth
	humanoid.Health = GAME_CONFIG.ZombieHealth
	
	-- Weld
	local weld = Instance.new("WeldConstraint")
	weld.Part0 = humanoidRootPart
	weld.Part1 = head
	weld.Parent = zombie
	
	zombie.Parent = workspace
	
	-- Manejar muerte
	humanoid.Died:Connect(function()
		GameState.ActiveZombies = GameState.ActiveZombies - 1
		if zombie:IsDescendantOf(workspace) then
			zombie:Destroy()
		end
	end)
	
	GameState.ActiveZombies = GameState.ActiveZombies + 1
	
	-- IA de persecución
	task.spawn(function()
		while zombie:IsDescendantOf(workspace) and humanoid.Health > 0 do
			local players = GetAllPlayers()
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
			
			if nearestPlayer and nearestPlayer.Character then
				local targetPos = nearestPlayer.Character.HumanoidRootPart.Position
				local direction = (targetPos - humanoidRootPart.Position).Unit
				humanoidRootPart.Velocity = direction * GAME_CONFIG.ZombieSpeed + Vector3.new(0, humanoidRootPart.Velocity.Y, 0)
			end
			
			task.wait(0.1)
		end
	end)
end

local function SpawnZombiesForWave()
	local spawner = workspace:FindFirstChild("ZombieSpawner")
	if not spawner then return end
	
	for i = 1, GameState.MaxWaveZombies do
		task.wait(1)
		SpawnZombie(spawner.Position)
	end
end

local function StartNewWave()
	GameState.CurrentWave = GameState.CurrentWave + 1
	GameState.MaxWaveZombies = GAME_CONFIG.InitialZombieCount + 
		(GameState.CurrentWave - 1) * GAME_CONFIG.ZombieIncrement
	
	if GameState.MaxWaveZombies > GAME_CONFIG.MaxZombies then
		GameState.MaxWaveZombies = GAME_CONFIG.MaxZombies
	end
	
	print("╔════════════════════════════════╗")
	print("  ONDA " .. GameState.CurrentWave .. " INICIADA")
	print("  Zombis: " .. GameState.MaxWaveZombies)
	print("╚════════════════════════════════╝")
	
	SpawnZombiesForWave()
end

-- ============================================
-- LOOP PRINCIPAL DEL JUEGO
-- ============================================

task.wait(5)

print("")
print("═══════════════════════════════════════")
print("  🧟 ZOMBIE GAME INICIADO")
print("═══════════════════════════════════════")

GameState.GameStarted = true

while true do
	StartNewWave()
	
	-- Esperar a que terminen todos los zombis o 60 segundos
	local waveStartTime = tick()
	while GameState.ActiveZombies > 0 and (tick() - waveStartTime) < 60 do
		task.wait(1)
	end
	
	print("✓ Onda " .. GameState.CurrentWave .. " completada")
	task.wait(GAME_CONFIG.WaveDelay)
end
