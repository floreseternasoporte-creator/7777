# ⚡ GUÍA RÁPIDA DE INSTALACIÓN

## 2 pasos para tener tu juego de zombis funcionando en 3 minutos

---

## PASO 1️⃣: Instalar ServerScript (Mapa + Oleadas)

1. Abre **Roblox Studio**
2. Crea un nuevo juego (vacío)
3. En el lado izquierdo, busca **ServerScriptService**
4. Haz clic derecho → **Insert Object → Script**
5. **Elimina** todo el contenido
6. **Copia** TODO el contenido de `ServerScript.lua`
7. **Pégalo** en el script de Roblox Studio
8. **Guarda** (Ctrl+S)

### ✅ Verifica que:
- En la consola (Output) veas el mensaje: "MAPA DE ZOMBIS GENERADO EXITOSAMENTE"
- Después veas: "🧟 ZOMBIE GAME INICIADO"
- El mapa aparezca en el viewport
- Los zombis comiencen a salir

---

## PASO 2️⃣: Instalar LocalScript (Combate)

1. En **StarterPlayer**, busca **StarterCharacterScripts**
2. Haz clic derecho → **Insert Object → LocalScript**
3. **Elimina** el contenido por defecto
4. **Copia** TODO el contenido de `LocalScript.lua`
5. **Pégalo** en el nuevo LocalScript
6. **Guarda**

### ✅ Verifica que:
- Cuando entres al juego, veas un contador de salud (❤️)
- Puedas atacar con **Click izquierdo** o **E**
- Los zombis reciban daño cuando los golpeas
- Veas los controles en la pantalla

---

## 🎮 ¡A JUGAR!

Presiona **Play** (botón de reproducción)

```
CONTROLES:
├─ WASD ............ Moverse
├─ Espacio ......... Saltar
├─ Click Izquierdo . Atacar
└─ E .............. Atacar (alternativa)
```

---

## 📋 Checklist de Instalación

- [ ] ServerScript.lua copiado en ServerScriptService
- [ ] Mapa visible con hierba, calles y edificios
- [ ] Zombis apareando en oleadas
- [ ] LocalScript.lua copiado en StarterCharacterScripts
- [ ] Puedo atacar y hacer daño a zombis
- [ ] Tengo un contador de salud visible

---

## ❌ Algo no funciona?

**Los scripts no ejecutan:**
- Abre Developer Console (Ctrl+Shift+C)
- Busca errores en la pestaña "Output"
- Verifica que el código esté completo

**El mapa no aparece:**
- Espera 10 segundos
- Haz click en Play nuevamente

**Los zombis no salen:**
- Asegúrate de tener ServerScript activado
- Verifica que haya un jugador conectado
- Mira la consola para logs

---

## 💾 Estructura Final Esperada

```
ServerScriptService
└─ Script (ServerScript.lua) ......... Mapa + Oleadas ✓

StarterPlayer
└─ StarterCharacterScripts
    └─ LocalScript (LocalScript.lua) . Combate ✓
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
