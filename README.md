# 🧟 ZOMBIE GAME - Roblox

Juego de zombis completo para Roblox con sistema de oleadas, terreno generado proceduralmente y mecánicas de combate.

---

## 📋 Contenido

- ✅ **ServerScript.lua** - Generador de mapa + Sistema de oleadas (TODO INTEGRADO)
- ✅ **LocalScript.lua** - Sistema de combate del jugador
- 📖 **Instrucciones de instalación**

---

## 🎮 Características del Mapa

### Terreno
- Terreno de hierba completo (256x256 studs)
- Generado automáticamente sin Baseplate

### Sistema de Calles
- **Calle Principal (Cruz)**: Atraviesa todo el mapa (este-oeste y norte-sur)
- **Calles Secundarias**: Forman una malla para mejor navegación
- **Tamaño**: 20 studs la principal, 12 studs las secundarias

### Edificios
- **4 Edificios en Esquinas**: De 40x40 studs c/u
  - Noreste (Dark stone grey)
  - Noroeste (Brown)
  - Sureste (Dark stone grey)
  - Suroeste (Brown)

- **4 Edificios Intermedios**: En puntos cardinales
  - Este y Oeste (Bright red)
  - Norte y Sur (Dark stone grey)

- **10 Árboles Decorativos**: En posiciones estratégicas

### Zonas Especiales
- 🟢 **Spawn de Jugadores** (verde): Centro del mapa
- 🔴 **Spawn de Zombis** (rojo): Esquina Sureste

---

## 📝 Cómo Instalar en Roblox Studio

### Paso 1: Crear un nuevo juego
1. Abre **Roblox Studio**
2. Crea un nuevo proyecto (puede ser vacío)

### Paso 2: Insertar ServerScript (Mapa + Oleadas)
1. En el explorador, haz clic derecho en **ServerScriptService**
2. Selecciona **InsertObject → Script**
3. Copia TODO el contenido de `ServerScript.lua`
4. Pégalo en el nuevo script
5. **Guarda** el proyecto (Ctrl+S)

### Paso 3: Insertar LocalScript (Combate)
1. En el explorador, navega a **StarterPlayer → StarterCharacterScripts**
2. Haz clic derecho y selecciona **InsertObject → LocalScript**
3. Copia TODO el contenido de `LocalScript.lua`
4. Pégalo en el nuevo LocalScript
5. **Guarda** el proyecto

### Paso 4: Esperar a que genere el mapa
- El script tardará unos segundos en generar todo
- Verás mensajes en la consola (Output) confirmando cada paso
- ✓ Cuando veas "MAPA DE ZOMBIS GENERADO EXITOSAMENTE" está listo

---

## 🎛️ Configuración Disponible

### En ServerScript.lua (Mapa + Oleadas):
```lua
local MAP_SIZE = 256                -- Tamaño total del mapa
local TERRAIN_HEIGHT = 10           -- Altura de la hierba

local GAME_CONFIG = {
    WaveDelay = 30,                 -- Segundos entre oleadas
    InitialZombieCount = 3,         -- Zombis en onda 1
    ZombieIncrement = 2,            -- Zombis adicionales por onda
    MaxZombies = 50,                -- Máximo de zombis a la vez
    ZombieHealth = 50,              -- Vida de cada zombi
    ZombieSpeed = 25,               -- Velocidad de movimiento
    KillReward = 25,                -- Dinero por matar zombi
}
```

### En LocalScript.lua (Combate):
```lua
local COMBAT_CONFIG = {
	AttackRange = 15,               -- Rango de ataque en studs
	AttackDamage = 25,              -- Daño por golpe
	AttackCooldown = 0.5,           -- Cooldown entre ataques (segundos)
}
```

---

## 🧟 Sistema de Oleadas

1. **Onda 1**: 3 zombis
2. **Onda 2**: 5 zombis
3. **Onda 3**: 7 zombis
4. Y así sucesivamente...

- Los zombis aparecen en la zona roja (Sureste)
- Persiguen automáticamente al jugador más cercano
- Si un jugador se acerca, el zombi intenta atacar

---

## 🎯 Próximos Pasos (Complementos)

### 1. Sistema de Armas
- Crear LocalScript para armas en el player
- Sistema de disparos/melee
- Detección de golpes a zombis

### 2. Sistema de Dinero/UI
- Mostrar dinero del jugador
- Tienda para comprar armas
- Display de onda actual

### 3. Spawn de Jugadores
- Script para teleportar jugadores al spawn (verde)
- Dar arma inicial

### 4. Mejoras de IA de Zombis
- Alejarse del fuego
- Atacar en grupo
- Diferentes tipos de zombis

---

## 📊 Estructura del Mapa (Coordenadas)

```
                (-256,-256)
                    N
                   NW|NE
            W ----  +  ---- E
                   SW|SE
                (256,256)
                    S

• Spawn Jugadores: (0, 10, 0) - Centro
• Spawn Zombis: (~220, 10, ~220) - Esquina Sureste
• Edificios: En las esquinas (+220, ±220)
```

---

## 🔧 Troubleshooting

**Problema**: El mapa no aparece
- Solución: Espera 10 segundos, recarga el proyecto

**Problema**: No hay gravedad
- Solución: Asegúrate que Humanoid esté en los caracteres

**Problema**: Los zombis no se mueven
- Solución: Verifica que haya jugadores en el juego

**Problema**: Los edificios desaparecen
- Solución: No elimines las partes manualmente, el juego las necesita

---

## 💡 Tips de Diseño

- ✅ Las calles son anchas para que los jugadores puedan regatear zombis
- ✅ Los edificios tienen techos para dar profundidad visual
- ✅ El terreno es plano para facilitar el movimiento
- ✅ Los árboles crean línea de visión interesante
- ✅ El spawn de zombis está alejado del spawn de jugadores

---

## 📄 Licencia

Este código es libre para usar en tus proyectos de Roblox.

---

## 📞 Notas Finales

- Los scripts están optimizados para rendimiento
- Usa el Output Console (Ctrl+Shift+C) para ver logs
- Puedes editar colores y tamaños sin romper la funcionalidad
- Los zombis se eliminan automáticamente al morir

¡A disfrutar tu juego de zombis! 🧟‍♂️🎮
