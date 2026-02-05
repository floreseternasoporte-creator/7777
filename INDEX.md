# 📚 ÍNDICE GENERAL - Tu Proyecto de Roblox Zombis

Bienvenido al juego de **Zombis para Roblox**. Esta es tu guía central para entender todo el proyecto.

---

## 🎯 Comienza Aquí

**Si es tu primera vez:**
→ Lee [**QUICK_START.md**](QUICK_START.md) primero (5 minutos)

**Si necesitas ajustes avanzados:**
→ Lee [**REFERENCE.md**](REFERENCE.md)

**Si algo no funciona:**
→ Consulta [**TESTING_CHECKLIST.md**](TESTING_CHECKLIST.md)

---

## 📁 Estructura de Archivos

### Archivos Principales (NECESARIOS)

#### 1️⃣ **ServerScript.lua**
- **Qué hace**: Genera todo el mapa (terreno, calles, edificios, árboles)
- **Dónde va**: ServerScriptService
- **Tiempo de ejecución**: Al iniciar
- **Líneas**: ~350
- **Dependencias**: Ninguna

```
Crea:
├─ Terreno de hierba (256x256 studs)
├─ 6 calles (hormigón)
├─ 8 edificios con techos
├─ 10 árboles decorativos
├─ Punto de spawn jugadores (verde)
└─ Punto de spawn zombis (rojo)
```

**Cómo usarlo:**
1. Copia TODO el contenido
2. Pega en un Script nuevo en ServerScriptService
3. ¡Listo! El mapa se genera automáticamente

---

### Archivos Secundarios (RECOMENDADOS)

#### 2️⃣ **GameManager.lua**
- **Qué hace**: Controla las oleadas de zombis y su comportamiento
- **Dónde va**: Otro Script en ServerScriptService
- **Tiempo de ejecución**: Después de ServerScript
- **Líneas**: ~300
- **Dependencias**: ServerScript (debe estar primero)

```
Funciones:
├─ Crear oleadas de zombis (1, 2, 3, ...)
├─ Spawnar zombis gradualmente
├─ IA simple (perseguir jugador)
├─ Detectar muertes de zombis
└─ Loop infinito de oleadas
```

**Configuración disponible:**
```lua
WaveDelay = 30              -- Esperar entre oleadas (segundos)
InitialZombieCount = 3      -- Zombis en onda 1
ZombieIncrement = 2         -- Zombis adicionales por onda
MaxZombies = 50             -- Máximo simultáneo
ZombieHealth = 50           -- Vida del zombi
ZombieSpeed = 25            -- Velocidad de movimiento
```

---

#### 3️⃣ **CombatSystem.lua**
- **Qué hace**: Permite al jugador atacar zombis y recibir daño
- **Dónde va**: StarterPlayer → StarterCharacterScripts
- **Tiempo de ejecución**: Cuando el jugador entra
- **Líneas**: ~200
- **Dependencias**: Solo necesita que el mapa esté cargado

```
Funciones:
├─ Sistema de ataque (click o tecla E)
├─ Cooldown de ataque
├─ Detección de golpes a zombis
├─ Recibir daño de zombis
├─ Mostrar UI de salud
└─ Mostrar controles en pantalla
```

**Controles automatizados:**
- Click Izquierdo → Atacar
- E → Atacar (alternativa)
- WASD → Moverse (valor por defecto)
- Espacio → Saltar (valor por defecto)

---

### Archivos de Documentación (CONSULTA)

#### 📖 **README.md** (La más completa)
- ✅ Descripción completa del sistema
- ✅ Características del mapa
- ✅ Instrucciones paso a paso
- ✅ Configuración disponible
- ✅ Tips de diseño
- ✅ Troubleshooting

**Usa si**: Quieres una guía exhaustiva

---

#### ⚡ **QUICK_START.md** (Rápido)
- ✅ Solo 3 pasos principales
- ✅ Checklist de verificación
- ✅ Estructura esperada
- ✅ Problemas rápidos

**Usa si**: Tienes prisa o es tu primera vez

---

#### 🗂️ **REFERENCE.md** (Técnico)
- ✅ Variables configurables
- ✅ Puntos de integración
- ✅ Flujo de ejecución
- ✅ Debugging
- ✅ Ideas de mejora

**Usa si**: Quieres modificar o expandir el sistema

---

#### 🎨 **MAP_VISUALIZATION.md** (Visual)
- ✅ Vista aérea del mapa
- ✅ Perspectiva 3D
- ✅ Leyenda de elementos
- ✅ Dimensiones exactas
- ✅ Estadísticas del mapa

**Usa si**: Quieres entender mejor la disposición

---

#### ✅ **TESTING_CHECKLIST.md** (Verificación)
- ✅ 8 fases de testing
- ✅ 65 items a verificar
- ✅ Soluciones a problemas comunes
- ✅ Guía de troubleshooting

**Usa si**: Algo no funciona o quieres verificar todo

---

## 🚀 Orden de Instalación Recomendado

### Opción A: Mínimo (Solo el mapa)
```
1. Instala ServerScript.lua
2. Presiona Play
3. ¡Listo! Tienes un mapa
```
**Resultado**: Mapa bonito pero sin zombis

---

### Opción B: Recomendado (Mapa + Zombis)
```
1. Instala ServerScript.lua
2. Instala GameManager.lua
3. Presiona Play
4. ¡Listo! Juga oleadas infinitas
```
**Resultado**: Gameplay completo

---

### Opción C: Full (Todo)
```
1. Instala ServerScript.lua
2. Instala GameManager.lua
3. Instala CombatSystem.lua
4. Presiona Play
5. ¡Listo! Juego completo
```
**Resultado**: Juego totalmente funcional

---

## 🎮 Flujo de Juego (Cómo se ve)

```
[Inicia Studio]
    ↓
[Se ejecuta ServerScript.lua]
    ↓ (5 segundos después)
[Se ejecuta GameManager.lua]
    ↓ (5 segundos después) 
[Presiona Play]
    ↓
[Apareces en el punto verde (centro)]
    ↓ (30 segundos esperando)
[Aparecen 3 zombis en el punto rojo]
    ↓
[Los zombis vienen hacia ti]
    ↓
[Los atacas con click izquierdo]
    ↓
[Se mueren]
    ↓ (60 segundos esperando)
[Aparecen 5 zombis (onda 2)]
    ↓
[Repite indefinidamente]
```

---

## ⚙️ Configuración Rápida

### Si el juego es muy fácil:
```lua
-- En GameManager.lua
ZombieHealth = 100          -- Más vida
ZombieSpeed = 35            -- Más rápido
WaveDelay = 15              -- Menos espera
```

### Si el juego es muy difícil:
```lua
-- En GameManager.lua
ZombieHealth = 25           -- Menos vida
ZombieSpeed = 15            -- Más lento
WaveDelay = 60              -- Más espera
MaxZombies = 25             -- Menos zombis
```

### Si el juego es lento:
```lua
-- En GameManager.lua
MaxZombies = 25             -- Reducir máximo
ZombieIncrement = 1         -- Menos por onda
```

---

## 🆘 Guía Rápida de Problemas

| Problema | Solución | Archivo |
|----------|----------|---------|
| Mapa no aparece | Esperar 10s, recargar | README.md |
| Zombis no salen | Verificar GameManager | TESTING_CHECKLIST.md |
| Combate no funciona | Verificar CombatSystem | QUICK_START.md |
| Errores en consola | Revisar REFERENCE.md | REFERENCE.md |
| No entiendo flujo | Ver MAP_VISUALIZATION.md | MAP_VISUALIZATION.md |

---

## 📊 Resumen de Capacidades

```
┌─────────────────────────────────────────────────┐
│         ZOMBIE GAME - CAPACIDADES               │
├─────────────────────────────────────────────────┤
│ Terreno:                                        │
│  ✓ Generado proceduralmente (sin Baseplate)    │
│  ✓ 256x256 studs de área de juego              │
│  ✓ Terreno de hierba + calles + edificios      │
│                                                 │
│ Zombis:                                         │
│  ✓ Spawn infinito en oleadas                   │
│  ✓ IA que persigue jugadores                   │
│  ✓ Sistema de daño y salud                     │
│  ✓ Hasta 50 simultáneos (configurable)        │
│                                                 │
│ Jugador:                                        │
│  ✓ Sistema de combate (ataque melee)           │
│  ✓ Recibir daño de zombis                      │
│  ✓ UI de salud en tiempo real                  │
│  ✓ Movimiento y salto normales                 │
│                                                 │
│ Juego:                                          │
│  ✓ Oleadas infinitas                           │
│  ✓ Dificultad aumenta (más zombis)            │
│  ✓ Controles intuitivos                        │
│  ✓ Completamente personalizable                │
└─────────────────────────────────────────────────┘
```

---

## 💡 Mejoras Sugeridas

Una vez funcione todo, considera:

- [ ] **Sistema de dinero** - Dar $ por matar zombis
- [ ] **Tienda** - Comprar armas con dinero
- [ ] **Armas variadas** - Pistola, escopeta, sniper
- [ ] **Diferentes zombis** - Fast, Tank, Ranged
- [ ] **Tabla de puntuaciones** - Mostrar Top 10
- [ ] **Sonidos** - Disparos, explosiones, muerte
- [ ] **Efectos visuales** - Sangre, explosiones, giros
- [ ] **Boss zombis** - Cada 10 ondas un jefe
- [ ] **Mapas múltiples** - Diferentes escenarios
- [ ] **Mutiplayer mejorado** - Cooperativo

---

## 📚 Lectura Recomendada

### Para Principiantes:
1. QUICK_START.md (5 min)
2. MAP_VISUALIZATION.md (5 min)
3. Consola Python de Roblox Studio

### Para Intermedios:
1. README.md (20 min)
2. REFERENCE.md (15 min)
3. Código de los scripts

### Para Avanzados:
1. Todos los scripts Lua
2. REFERENCE.md (técnicas avanzadas)
3. Roblox API documentation

---

## 🔗 Estructura de Carpetas Esperada

```
Tu Proyecto Roblox (en Studio)
├── ServerScriptService
│   ├── Script (ServerScript.lua) ......... Mapa
│   └── Script (GameManager.lua) ......... Zombis
│
└── StarterPlayer
    └── StarterCharacterScripts
        └── Script (CombatSystem.lua) ... Combate

Archivos de Documentación (en esta carpeta)
├── README.md ............................ Guía completa
├── QUICK_START.md ...................... Inicio rápido
├── REFERENCE.md ........................ Referencia técnica
├── MAP_VISUALIZATION.md ............... Visualización
├── TESTING_CHECKLIST.md ............... Testing
└── INDEX.md ........................... Este archivo
```

---

## 🏁 Checklist Final

Antes de decir que terminaste:

- [ ] Leí QUICK_START.md
- [ ] Instalé ServerScript.lua
- [ ] Instalé GameManager.lua (opcional)
- [ ] Instalé CombatSystem.lua (opcional)
- [ ] Pasé TESTING_CHECKLIST.md
- [ ] El mapa se ve bien
- [ ] Los zombis funcionan
- [ ] El combate funciona
- [ ] Entiendo cómo personalizar
- [ ] Sé dónde buscar ayuda

---

## 📞 Recursos Útiles

- **Documentación Roblox**: https://dev.roblox.com
- **Lua Guide**: https://lua.org/manual
- **Roblox API**: Busca "Roblox API" en Google

---

## 🎉 ¡Ya estás listo!

Tu juego de zombis está completamente preparado. 

**Próximos pasos:**
1. Instala los scripts
2. Prueba el juego
3. Personaliza según tus gustos
4. ¡Diviértete!

---

**Última actualización**: Febrero 2026
**Version**: 1.0
**Estado**: ✅ Completamente funcional
