# 🗂️ REFERENCIA TÉCNICA - Estructura del Juego

## Resumen de archivos

```
📁 Tu Proyecto Roblox
├── 📄 ServerScript.lua ................. [★ PRINCIPAL] Generador de mapa
├── 📄 GameManager.lua ................. [★ IMPORTANTE] Sistema de oleadas
├── 📄 CombatSystem.lua ................ [Opcional] Sistema de combate
├── 📄 README.md ....................... Documentación completa
├── 📄 QUICK_START.md .................. Guía rápida (este archivo)
└── 📄 REFERENCE.md .................... Referencia técnica
```

---

## 🏗️ Arquitectura del Mapa

### Terreno
```
┌─────────────────────────────────────────────┐
│                                             │
│          ZONA DE JUEGO (256x256)            │
│                                             │
│     Terreno de hierba + calles + edificios  │
│                                             │
└─────────────────────────────────────────────┘

Altura del terreno: 10 studs
Altura de edificios: 40 studs
Espacio libre en centro: Para combate
```

### Disposición de Edificios

```
            Onda N
            (0,-220)
              ║
              ║
Edificio NW   ║   Edificio NE
(-220,-220)   ║   (220,-220)
  ┌───────────╬───────────┐
  │           ║           │
  │────  Calle Principal ──│
───┼─────  (Centro)  ─────┼─── Calle Este-Oeste
  │────  Calle Principal ──│
  │           ║           │
  └───────────╬───────────┘
Edificio SW   ║   Edificio SE
(-220,220)    ║   (220,220)
              ║
              ║       🔴 Spawn Zombis
            Onda S     (220,220)
           (0,220)
```

---

## 🗂️ Objetos en el Workspace

### Partes de Terreno
- `Grass` - Terrain (material Grass)
- `Street` (múltiples) - Material Concrete

### Edificios
- `Building_NE` - Noreste (Dark stone grey)
- `Building_NW` - Noroeste (Brown)
- `Building_SE` - Sureste (Dark stone grey)
- `Building_SW` - Suroeste (Brown)
- `Building_E` - Este (Bright red)
- `Building_W` - Oeste (Dark stone grey)
- `Building_N` - Norte (Brown)
- `Building_S` - Sur (Bright red)

### Utilidades
- `SpawnPart` - Punto de spawn jugadores (Neon verde)
- `ZombieSpawner` - Punto de spawn zombis (Neon rojo)

### Árboles
- `TreeTrunk` (x10) - Troncos cilíndricos
- `TreeCrown` (x10) - Copas (esferas verdes)

### Zombis (Generados dinámicamente)
- `Zombie_[onda]_[número]` - Modelo de zombi
  - HumanoidRootPart (cuerpo)
  - Head (cabeza)
  - Humanoid (atributos)

---

## 📊 Variables Configurables

### Tamaño y Posición
```lua
MAP_SIZE = 256                  -- Tamaño total en studs
TERRAIN_HEIGHT = 10            -- Altura base
buildingSize = 40              -- Tamaño edificios esquina
mediumBuildingSize = 30        -- Tamaño edificios intermedios
cornerDistance = MAP_SIZE - 30 -- Distancia a las esquinas
streetWidth = 20               -- Ancho calle principal
```

### Zombis (GameManager)
```lua
WaveDelay = 30                 -- Segundos entre oleadas
InitialZombieCount = 3         -- Zombis primera onda
ZombieIncrement = 2            -- Incremento por onda
MaxZombies = 50                -- Máximo simultáneo
ZombieHealth = 50              -- Vida inicial zombi
ZombieSpeed = 25               -- Velocidad movimiento
KillReward = 25                -- Dinero por matar
```

### Combate (CombatSystem)
```lua
AttackRange = 15               -- Rango golpe en studs
AttackDamage = 25              -- Daño por golpe
AttackCooldown = 0.5           -- Tiempo entre golpes
```

---

## 🔌 Puntos de Integración

### Para agregar sistema de dinero:
```lua
-- En GameManager, cuando muere un zombi:
GameManager:GivePlayerMoney(player, GameManager.Config.KillReward)
```

### Para crear nuevos tipos de zombis:
```lua
function GameManager:SpawnZombie(position, type)
    -- Modificar color, salud, velocidad según type
    if type == "fast" then
        ZombieSpeed = 35
    elseif type == "tank" then
        ZombieHealth = 100
    end
end
```

### Para agregar armas:
```lua
-- En CombatSystem, agregar más tipos de armas
if weaponType == "gun" then
    COMBAT_CONFIG.AttackRange = 50
    COMBAT_CONFIG.AttackDamage = 50
end
```

---

## ⚡ Flujo de Ejecución

```
1. ServerScript.lua ejecuta al iniciar
   ├─ Limpia el terreno
   ├─ Genera hierba
   ├─ Crea calles
   ├─ Construye edificios
   ├─ Planta árboles
   ├─ Crea punto de spawn
   └─ Crea zona de spawn de zombis

2. GameManager.lua comienza (después de ~7 segundos)
   ├─ Espera a que carguen jugadores
   ├─ Inicia onda 1
   └─ Loop infinito de oleadas
        ├─ Spawn zombis gradualmente
        ├─ Espera terminen o 60 segundos
        └─ Pasa a siguiente onda

3. CombatSystem.lua se carga cuando jugador entra
   ├─ Crea herramienta
   ├─ Configura AI
   ├─ Crea UI de salud
   └─ Escucha inputs de combate
```

---

## 🎯 Señales (Connections) Importantes

```lua
-- GameManager
humanoid.Died:Connect() ............ Detecta zombi muerto
task.spawn() ....................... Loop de IA asincrónico

-- CombatSystem
UserInputService.InputBegan() ...... Detecta ataque jugador
humanoid.HealthChanged() ........... Actualiza UI
humanoid.Touched() ................. Detecta daño zombi
```

---

## 📈 Escalabilidad

### Aumentar dificultad:
1. Reducir `WaveDelay` en GameManager
2. Aumentar `ZombieIncrement`
3. Reducir `ZombieHealth`

### Aumentar complejidad:
1. Agregar más edificios en ServerScript
2. Crear tipos de zombis diferentes en GameManager
3. Implementar armas variadas en CombatSystem

### Optimizaciones:
1. Usar `task.spawn()` para no bloquear main thread
2. Limitar número máximo de zombis en `MaxZombies`
3. Destruir zombis al morir para liberar memoria

---

## 📱 UI Generada Automáticamente

```
┌─────────────────────────────┐
│ ❤️ Salud: 100/100           │ (Arriba izquierda)
└─────────────────────────────┘

┌─────────────────────────────┐
│ CONTROLES:                  │
│ WASD - Moverse              │ (Centro izquierda)
│ Click Izquierdo - Atacar    │
│ E - Atacar (Alternativa)    │
│ Espacio - Saltar            │
└─────────────────────────────┘
```

---

## 🔍 Debugging

### Ver logs:
```
Roblox Studio → View → Output (Ctrl+Shift+C)
```

### Información importante:
```
✓ Terreno generado
✓ Calles generadas
✓ Edificios en esquinas generados
✓ Árboles decorativos plantados
✓ Punto de spawn creado
✓ Área de spawn de zombis creada
✓ MAPA DE ZOMBIS GENERADO EXITOSAMENTE
```

---

## 🚀 Mejoras Futuras Sugeridas

- [ ] Sistema de tienda (botiq)
- [ ] Armas variadas (pistola, escopeta, rifle)
- [ ] Tabla de puntuaciones
- [ ] Sistema de rondas con rewards
- [ ] Efectos visuales (sangre, explosiones)
- [ ] Sonidos (disparo, zombi, muerte)
- [ ] Diferentes tipos de zombis
- [ ] Boss zombis cada 10 ondas
- [ ] Mapas múltiples
- [ ] Modo multijugador mejorado

---

Generated: Febrero 2026
Game Type: Roblox Zombie Survival
