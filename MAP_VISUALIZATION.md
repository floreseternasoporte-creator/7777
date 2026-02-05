# 🎨 VISUALIZACIÓN DEL MAPA

## Vista Aérea del Mapa Completo

```
                        NORTE
                          ↓
     
     (-256,-256) ┌────────────────────────────────┐ (256,-256)
              │ NW Edificio                 NE Edificio │
              │                                        │
              │    ┌─────────────────────────┐        │
              │    │    🌳🌳  Árbol  🌳🌳    │        │
              │    │                        │        │
              │    │                        │        │
              │    │       CALLE NORTE      │        │
              │    │     ╔════════════╗     │        │
              │    │     ║            ║     │        │
      ════════╬════════╬═╝    Terreno  ╚═╬════════╬════════
    Oeste              │    de Hierba   │            Este
      ════════╬════════╬═╗   (Verde)    ╔═╬════════╬════════
              │    │     ║            ║     │        │
              │    │     ╚════════════╝     │        │
 C             │    │                        │        │
 A             │    │       CALLE SUR       │        │
 L             │    └─────────────────────────┘        │
 L             │                                        │
 E             │ SW Edificio              SE Edificio  🔴 │
 S             │                                   Spawn Zombis
              │
              │    ┌──────────────────────────┐        │
              │    │ 🌳     Árbol       🌳    │        │
              │    │ 🌳                  🌳   │        │
              │    │                         │        │
              │    └──────────────────────────┘        │
     (-256,256) └────────────────────────────────┐ (256,256)
                        ↑
                      SUR
```

## Leyenda

```
NW Edificio    → Edificio Noroeste (Brown) - 40x40 studs
NE Edificio    → Edificio Noreste (Dark stone grey) - 40x40 studs
SW Edificio    → Edificio Suroeste (Brown) - 40x40 studs  
SE Edificio    → Edificio Sureste (Dark stone grey) - 40x40 studs

Edificios intermedios:
E Edificio     → Edificio Este (Bright red) - 30x30 studs
W Edificio     → Edificio Oeste (Dark stone grey) - 30x30 studs
N Edificio     → Edificio Norte (Brown) - 30x30 studs
S Edificio     → Edificio Sur (Bright red) - 30x30 studs

🌳                → Árboles (10 en total, decorativos)
═════════════    → Calles principales (ancho 20 studs)
─────────────    → Calles secundarias (ancho 12 studs)
Terreno Verde    → Grass terrain (material predeterminado)
🟢 SpawnPart     → Punto de spawn jugadores (centro)
🔴 Spawn Zombis  → Punto de spawn de zombis
```

---

## Vista Frontal (Lado Este)

```
                    Edificio NE
                    ╔════════╗
                    ║        ║
                    ║  40x40 ║
                    ║        ║
                    ╚════════╝

         ═══════════════════════════════════════  ← Calle Este-Oeste
                      (Ancho: 20)

                    El Terreno
                 ╔════════════════╗
                 ║   Hierba       ║
                 ║   Verde        ║
                 ║   x256x256     ║
                 ╚════════════════╝

         ═══════════════════════════════════════

                    Edificio SE
                    ╔════════╗
                    ║        ║
                    ║  40x40 ║
                    ║        ║
                    ╚════════╝
                    🔴 Spawn Zombis
```

---

## Vista 3D Perspectiva

```
                     Cielo
                      ↓
        ┌─────────────────────────────┐ <- Altura máxima (edificios)
        │                             │
        │  Cubes = Edificios          │
        │  Verde = Terreno            │
        │  Gris = Calles              │
        │                             │
        └─────────────────────────────┘
         A                           A
         │ Alt = 40 studs            │
         │                           │
         A                           A
         │ Alt = 10 studs (terreno)  │
    ═════════════════════════════════════
         Bajo tierra / Ground Level
```

---

## Diferentes Escenarios de Juego

### Escenario 1: Combate en Centro
```
    [Jugador 1] 🟢 Spawnea en el centro
                 ↓
           Busca zombis
                 ↓
          [Zombi]: 🧟 Aparece en rojo
                 ↓
           Se persiguen en calles
```

### Escenario 2: Defensa en Edificio
```
    [Jugador] sube al techo de edificio
         ↓
    Los zombis vienen hacia él
         ↓
    Jugador ataca desde altura
```

### Escenario 3: Oleadas
```
    ONDA 1: 3 zombis        (Fácil)
        ↓
    ONDA 2: 5 zombis        (Moderado)
        ↓
    ONDA 3: 7 zombis        (Difícil)
        ↓
    ONDA 4: 9 zombis        (Muy difícil)
        ↓
    ... continúa infinitamente
```

---

## Materiales Utilizados

### Terreno
- **Grass** (Material Roblox) - Color verde
- **Concrete** (Material Roblox) - Gris oscuro para calles

### Edificios
- **Brick** (Material Roblox) - Rojo, marrón, gris
- **Slate** (Material Roblox) - Techos oscuros

### Árboles
- **Wood** - Troncos marrones
- **Grass** - Copas verdes (esferas)

### Especiales
- **Neon** - Puntos de spawn (brillo)
- **Metal** - Armas/herramientas

---

## Dimensiones Finales

```
Mapa Total:
  • Ancho (X): -256 a 256 (512 studs)
  • Profundo (Z): -256 a 256 (512 studs)
  • Alto (Y): 0 a 50+ studs

Terreno:
  • Diámetro: ~305 studs (esfera)
  • Altura: 10 studs

Edificios Esquina:
  • Tamaño: 40x40x40 studs
  • Posición: 220 studs de esquina

Edificios Intermedios:
  • Tamaño: 30x30x30 studs
  • Posición: Puntos cardinales

Calles:
  • Principal: 20 studs de ancho
  • Secundarias: 12 studs de ancho
```

---

## Flujo Visual de Juego

```
┌──────────────────────────────────────────────┐
│  Jugador entra al juego                      │
│  ↓                                           │
│  Aparece en SpawnPart (🟢 verde, centro)    │
│  ↓                                           │
│  Onda 1 comienza: 3 zombis salen de 🔴 rojo│
│  ↓                                           │
│  Zombis buscan al jugador                    │
│  ├─ Si lo ven: van hacia él                  │
│  ├─ Si está cerca: lo atacan                 │
│  └─ El jugador ataca con click               │
│  ↓                                           │
│  ¿Mueren todos los zombis?                   │
│  ├─ SÍ → Esperar 30 segundos, siguiente onda │
│  └─ NO → Continuar combate                   │
└──────────────────────────────────────────────┘
```

---

## Elementos Interactivos

### Colisionables
- ✅ Terreno (Solid)
- ✅ Edificios (Solid)
- ✅ Calles (Solid)
- ✅ Árboles (Troncos sólidos)

### No Colisionables
- ❌ Copas de árboles (decoración)
- ❌ UI de salud (canvas)
- ❌ Puntos de spawn (solo referencia)

---

## Estadísticas del Mapa

```
Total de Partes Estáticas:
  • Edificios: 8 (+ 8 techos) = 16 partes
  • Calles: 6 = 6 partes
  • Árboles: 10 troncos + 10 copas = 20 partes
  • Terreno: 1 (Terrain object)
  • Spawn: 2 (SpawnPart + ZombieSpawner)
  ─────────────────────────────────────────
  TOTAL: ~45 partes estáticas

Dinámicas (se crean al jugar):
  • 1 Zombi por jugador (configurable)
  • Máximo 50 zombis simultáneamente
```

---

## Color Reference

```
Brown           → #8B4513 (Edificios SW/NW)
Dark Stone Grey → #595959 (Edificios NE/SE, techos)
Bright Red      → #FF0000 (Edificios E/S)
Dark Green      → #155724 (Copas de árboles)
Bright Green    → #00FF00 (Spawn Point)
Reddish Brown   → #8B4513 (Troncos)
Concrete Grey   → #808080 (Calles)
```

---

Generated: Febrero 2026
Game: Zombie Survival Roblox
