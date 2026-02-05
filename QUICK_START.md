# ⚡ GUÍA RÁPIDA DE INSTALACIÓN

## 3 pasos para tener tu juego de zombis funcionando en 5 minutos

---

## PASO 1️⃣: Copiar script del mapa

1. Abre **Roblox Studio**
2. Crea un nuevo juego (vacío)
3. En el lado izquierdo, busca **ServerScriptService**
4. Haz clic derecho → **Insert Object → Script**
5. **Elimina** el código por defecto (select all + delete)
6. **Copia** TODO el contenido de `ServerScript.lua` (el archivo completo)
7. **Pégalo** en el script de Roblox Studio
8. **Guarda** (Ctrl+S)

### ✅ Verifica que:
- En la consola (Output) veas el mensaje: "MAPA DE ZOMBIS GENERADO EXITOSAMENTE"
- El mapa aparezca en el viewport
- Veas hierba, calles y edificios

---

## PASO 2️⃣: (OPCIONAL) Añadir sistema de oleadas

1. En **ServerScriptService**, crea **OTRO** script nuevo
2. **Copia** el contenido completo de `GameManager.lua`
3. **Pégalo** en el nuevo script
4. **Guarda**

### ✅ Verifica que:
- En la consola aparezca: "ZOMBIE GAME INICIADO"
- Después de unos segundos: "ONDA 1 INICIADA"
- Los zombis (partes verdes) aparezcan en la esquina roja

---

## PASO 3️⃣: (OPCIONAL) Sistema de combate

1. En **StarterPlayer → StarterCharacterScripts**, crea un **NUEVO** Script
2. **Copia** el contenido completo de `CombatSystem.lua`
3. **Pégalo**
4. **Guarda**

### ✅ Verifica que:
- Cuando entres al juego, veas un contador de salud (❤️)
- Puedas atacar con **Click izquierdo** o **E**
- Los zombis reciban daño cuando los golpeas

---

## 🎮 ¡A JUGAR!

Presiona **Play** (botón de reproducción) en Roblox Studio

```
CONTROLES:
├─ WASD ............ Moverse
├─ Espacio ......... Saltar
├─ Click Izquierdo . Atacar
└─ E .............. Atacar (alternativa)
```

---

## 📋 Checklist de Instalación

- [ ] Script del mapa creado en ServerScriptService
- [ ] Mapa visible con hierba, calles y edificios
- [ ] GameManager creado (opcional pero recomendado)
- [ ] Zombis apareciendo en oleadas
- [ ] CombatSystem creado (opcional)
- [ ] Puedo atacar y hacer daño a zombis

---

## ❌ Algo no funciona?

**Los scripts no ejecutan:**
- Abre Developer Console (Ctrl+Shift+C)
- Busca errores en la pestaña "Output"
- Verifica que el código esté completo (no cortado)

**El mapa no aparece:**
- Espera 10 segundos
- Haz click en Play nuevamente
- Verifica que el script esté en ServerScriptService (rojo)

**Los zombis no salen:**
- Asegúrate de tener GameManager activado
- Verifica que haya un jugador conectado
- Mira la consola para logs de error

---

## 💾 Estructura Final Esperada

```
ServerScriptService
├─ Script (ServerScript.lua) ............ Mapa ✓
├─ Script (GameManager.lua) ............ Oleadas ✓
└─ [más scripts si lo deseas]

StarterPlayer
└─ StarterCharacterScripts
    └─ Script (CombatSystem.lua) ....... Combate ✓
```

---

## 📞 Próximos Pasos

Una vez que tengas el juego funcionando:
- 🛒 Añade una tienda de armas
- 💰 Implementa sistema de dinero
- 🏆 Crea tabla de puntuaciones
- 🎨 Personaliza colores y texturas
- 🎵 Agrega sonidos de explosión

---

¡Diviértete creando tu juego de zombis! 🧟‍♂️
