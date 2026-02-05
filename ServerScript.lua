--[[
	ZOMBIE GAME MAP GENERATOR
	Este script genera un mapa completo para un juego de zombis en Roblox
	Incluye: Terreno con hierba, calles, y edificios en las esquinas
]]

local Terrain = workspace.Terrain

-- Configuración del mapa
local MAP_SIZE = 256  -- Tamaño del mapa en studs
local TERRAIN_HEIGHT = 10  -- Altura del terreno
local GRASS_SIZE = MAP_SIZE * 2  -- Área de hierba

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
-- FINALIZACIÓN
-- ============================================
print("╔══════════════════════════════════════╗")
print("║  MAPA DE ZOMBIS GENERADO EXITOSAMENTE  ║")
print("╚══════════════════════════════════════╝")
print("")
print("📍 Características del mapa:")
print("   • Terreno completo con hierba")
print("   • Sistema de calles (principal + secundarias)")
print("   • 8 edificios estratégicamente colocados")
print("   • Árboles decorativos")
print("   • Punto de spawn para jugadores (verde)")
print("   • Área de spawn de zombis (rojo)")
print("")
print("💡 Próximos pasos:")
print("   1. Crear script de zombis")
print("   2. Crear sistema de armas")
print("   3. Crear interfaz de jugador")
print("   4. Implementar lógica de ondas")
