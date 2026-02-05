# ✅ TESTING CHECKLIST - Verificación Completa

Usa esta lista para verificar que tu juego está funcionando correctamente.

---

## 📋 FASE 1: Instalación del ServerScript

- [ ] **ServerScript instalado** en ServerScriptService
- [ ] **No hay errores** en Output (Ctrl+Shift+C)
- [ ] **Mensaje de éxito** aparece en consola:
  ```
  ✓ Terreno de hierba generado
  ✓ Calles generadas
  ✓ Edificios en esquinas generados
  ✓ Edificios intermedios generados
  ✓ Árboles decorativos plantados
  ✓ Punto de spawn creado
  ✓ Área de spawn de zombis creada
  ║ MAPA DE ZOMBIS GENERADO EXITOSAMENTE
  🧟 ZOMBIE GAME INICIADO
  ```

---

## 🗺️ FASE 2: Verificación Visual del Mapa

Presiona **Play** y verifica:

- [ ] **Terreno**: Puedes ver una zona grande de hierba verde
- [ ] **Calles**: Hay caminos grises/hormigón
  - [ ] Una calle principal que va norte-sur
  - [ ] Una calle principal que va este-oeste  
  - [ ] Calles secundarias menores
- [ ] **Edificios**: 8 estructuras visibles
  - [ ] 4 en las esquinas (grandes)
  - [ ] 4 en posiciones intermedias (medianos)
- [ ] **Árboles**: 10 árboles decorativos esparcidos
- [ ] **Spawn Point**: Punto verde en el centro (donde apareces)
- [ ] **Spawn Zombis**: Punto rojo en la esquina sureste
- [ ] **Sin Baseplate**: La plataforma predeterminada ha sido removida

---

## 🧟 FASE 3: Sistema de Oleadas (Integrado en ServerScript)

- [ ] **ServerScript activado** en ServerScriptService
- [ ] **Sin errores** en consola
- [ ] **Mensaje de inicio** aparece:
  ```
  🧟 ZOMBIE GAME INICIADO
  ```
- [ ] **Después de ~30 segundos** aparece:
  ```
  ONDA 1 INICIADA
  Zombis: 3
  ```
- [ ] **3 partes verdes** (zombis) aparecen en la esquina roja
- [ ] **Los zombis se mueven** hacia tu personaje
- [ ] **Los zombis desaparecen** cuando los matas
- [ ] **Después de unos 60 segundos** sale el mensaje de Onda 2
- [ ] **Onda 2 tiene más zombis** (5 zombis)

---

## ⚔️ FASE 4: Sistema de Combate (si instalaste LocalScript)

### UI
- [ ] **Medidor de Salud** visible (arriba izquierda)
  - [ ] Muestra "❤️ Salud: 100/100"
  - [ ] Se actualiza cuando recibes daño
- [ ] **Panel de Controles** visible (centro izquierda)
  - [ ] Muestra WASD, Espacio, Click, E

### Movimiento
- [ ] **WASD** te mueve por el mapa ✓
- [ ] **Espacio** salta ✓
- [ ] Puedes **trepar edificios** (opcional pero bueno)

### Combate
- [ ] **Click izquierdo** intenta atacar
- [ ] **E** también funciona como ataque (alternativa)
- [ ] **El cursor cambia** cuando atacas
- [ ] **Los zombis reciben daño** cuando los golpeas
  - [ ] Probablemente veas "¡Golpe a Zombie_..." en consola
- [ ] **Los zombis mueren** cuando alcanzan 0 de salud
  - [ ] Se eliminan automáticamente
  - [ ] Desaparecen de la pantalla

### Daño al Jugador
- [ ] Los zombis pueden **dañarte**
- [ ] Tu salud **disminuye** cuando un zombi te toca
- [ ] El color de salud cambia a **rojo** cuando está bajo

---

## 🎮 FASE 5: Flujo Completo de Juego

Juega una partida completa y verifica:

- [ ] **Apareces** en el punto verde (centro)
- [ ] **Zombis salen** de la esquina roja
- [ ] **Zombis te persiguen** a través del mapa
- [ ] **Puedes esquivarlos** usando las calles y edificios
- [ ] **Puedes atacarlos** y verlos morir
- [ ] **Recibes daño** cuando se acercan
- [ ] **Se usa salud correctamente** (no infinita)
- [ ] **Primera onda termina** (todos los zombis muertos)
- [ ] **Segunda onda comienza** (esperas 30 segundos)
- [ ] **Segunda onda es más difícil** (más zombis)

---

## 🐛 FASE 6: Detección de Errores

Abre la consola (Ctrl+Shift+C) y busca:

- [ ] ❌ **NO hay errores de syntax** (líneas rojo brillante)
- [ ] ❌ **NO hay errores de undefined** ("índice es nil")
- [ ] ❌ **NO hay warnings** de partes (al menos no muchos)
- [ ] ✅ **SÍ hay mensajes informativos** (logs verdes/azules)

### Si hay errores:
```
Copia exactamente el mensaje de error
Abre REFERENCE.md -> Troubleshooting
O revisa que los scripts estén completos
```

---

## 📊 FASE 7: Performance

- [ ] **El FPS es estable** (no baja de 30 fps)
- [ ] **No hay lag** al spawnear zombis
- [ ] **Movimiento es suave** sin stuttering
- [ ] **La cámara responde bien**

Si es lento:
- Reduce `MaxZombies` en GameManager
- Aumenta `WaveDelay`

---

## 🎨 FASE 8: Verificación Visual Avanzada

En el viewport de Studio:

- [ ] **Los materiales se ven correctos**
  - [ ] Hierba es verde
  - [ ] Calles son grises/hormigón
  - [ ] Edificios tienen distintos colores
  - [ ] Techos son oscuros
- [ ] **Las sombras** se visualizan correctamente
- [ ] **No hay partes pegadas** unas a otras
- [ ] **El mapa es simétrico** (aproximadamente)

---

## 🔊 FASE 9: Verificaciones Adicionales (Bonus)

- [ ] Al atacar, **emite algún sonido** (si está configurado)
- [ ] Al morir, **emite sonido** (si está configurado)
- [ ] **Las partes no desaparecen** sin razón
- [ ] **Los árboles no son colisionables** (puedes para a través)
- [ ] Los **edificios bloquean movimiento** (colisionables)

---

## 🏆 Puntuación Final

Marca cada sección:
- **Fase 1 (Mapa)**: __/8 items
- **Fase 2 (Visual)**: __/11 items
- **Fase 3 (Oleadas)**: __/8 items
- **Fase 4 (Combate)**: __/13 items
- **Fase 5 (Flujo)**: __/8 items
- **Fase 6 (Errores)**: __/4 items
- **Fase 7 (Performance)**: __/4 items
- **Fase 8 (Visual Avanzada)**: __/5 items

**Total**: __/65 items

- 🟢 **60-65**: ¡Perfecto! Juego completamente funcional
- 🟡 **50-59**: Bueno, pero algunos problemas menores
- 🔴 **Menos de 50**: Necesita fixes importantes

---

## 🐛 Problemas Comunes y Soluciones

### Problema: Los scripts no ejecutan
```
❌ Error: "Attempt to index nil with..."
```
**Soluciones:**
1. Verifica que el script esté en **ServerScriptService** (rojo)
2. Asegúrate de que el código esté **completo** (sin cortes)
3. Recarga Studio: File → Recent Games → Tu Juego
4. Copia-pega el código nuevamente

---

### Problema: El mapa no aparece
```
❌ No hay terreno, solo el cielo
```
**Soluciones:**
1. Espera 10 segundos después de presionar Play
2. Verifica el Output para mensajes de error
3. Abre el Terrain Editor (View → Terrain Editor)
4. Mira si hay "Grass" en la lista

---

### Problema: Los zombis no salen
```
❌ No aparecen criaturas verdes
```
**Soluciones:**
1. Verifica que ServerScript esté instalado
2. En Output, busca "ZOMBIE GAME INICIADO"
3. Espera 35 segundos (5 de startup + 30 de WaveDelay)
4. Si nada aparece, revisa consola para errores

---

### Problema: Mi personaje se queda pegado
```
❌ No puedo moverme después de aparecer
```
**Soluciones:**
1. Verifica que SpawnPart no esté sólido (CanCollide = false)
2. Intenta aparecer en el aire (Position más alto)
3. Recarga el juego (Stop y Play nuevamente)

---

### Problema: Los zombis no me atacan
```
❌ Se mueven pero no hacen daño
```
**Soluciones:**
1. Asegúrate que el LocalScript esté activado
2. Acércate más al zombi (menos de 5 studs)
3. Verifica Output para mensajes de ataque
4. Recarga el juego completo

---

### Problema: El juego es muy lento
```
❌ FPS bajo, todo va en cámara lenta
```
**Soluciones:**
1. Reduce `MaxZombies` a 25 en GameManager
2. Reduce `ZombieIncrement` a 1
3. Cierra otros programas
4. Usa Ctrl+L para limpiar Output

---

## 📞 Si nada funciona

1. **Paso 1**: Abre el Output (Ctrl+Shift+C)
2. **Paso 2**: Copia todo el contenido usando Ctrl+A
3. **Paso 3**: Pega aquí y busca la línea con ERROR
4. **Paso 4**: Compara ese error con "Problemas Comunes"

---

## ✅ Checklist de Entrega Final

Antes de decir "¡Juego terminado!":

- [ ] El mapa se genera completamente
- [ ] Los zombis appear y se mueven
- [ ] El ServerScript ejecuta sin errores
- [ ] el LocalScript ejecuta sin errores
- [ ] El jugador puede lastimar zombis
- [ ] Los zombis pueden lastimar al jugador
- [ ] El sistema de oleadas funciona
- [ ] FPS es aceptable (>30)
- [ ] Puedes jugar mínimo 3 ondas sin crashes

---

**Si todas las casillas están marcadas: ¡Felicidades, tu juego está LISTO!** 🎉

Generated: Febrero 2026
