# NavBar iOS 26 Liquid Glass

Una demostración Flutter de una barra de navegación flotante inspirada en el
lenguaje visual Liquid Glass de iOS 26, adaptada para ejecutarse también en
Android y iOS 15 o posterior.

## Características

- Cápsula flotante con desenfoque real del contenido, tintes, borde luminoso y
  sombras multicapa.
- Lente activa animada con brillo especular continuo.
- Botón principal central elevado con flujo líquido continuo, hundimiento bajo
  el dedo, ondas expansivas y acciones rápidas.
- Cambio de sección tocando o deslizando directamente sobre la barra.
- Navegación lateral mediante `PageView`.
- Compatibilidad con reducción de movimiento y alto contraste.
- Animaciones aisladas con `RepaintBoundary` para no repintar continuamente el
  desenfoque completo.
- Sin dependencias visuales de terceros en tiempo de ejecución.

## Ejecutar

Requiere Flutter compatible con Dart 3.10 o posterior.

La variante verde `v1.1.0` es la predeterminada. Su acento parte del verde
bosque del logo de referencia y se eleva ligeramente para conservar contraste
sobre el cristal. La cápsula usa una opacidad base de `0.20`.

```bash
flutter pub get
flutter run
```

La variante azul original permanece disponible en el tag `v1.0.0` y también
puede compilarse desde el código actual con su opacidad base de `0.29`:

```bash
flutter run --dart-define=LIQUID_GLASS_THEME=blue
```

Para elegir la verde explícitamente:

```bash
flutter run --dart-define=LIQUID_GLASS_THEME=green
```

Para evaluar la fluidez en un dispositivo físico usa profile mode:

```bash
flutter run --profile
```

## Validación

```bash
flutter analyze
flutter test
flutter build apk --profile
```

## Nota sobre Liquid Glass

Esta es una recreación visual hecha con APIs de Flutter como `BackdropFilter`,
gradientes, capas especulares y animaciones. En Android no utiliza el material
propietario de Apple, por lo que busca una apariencia cercana manteniendo buen
rendimiento y accesibilidad.

El proyecto parte del ejemplo público
[`vdev-youtube/untitled8`](https://github.com/vdev-youtube/untitled8) y conserva
su historial y atribución mediante un fork. iOS y Liquid Glass son referencias
de diseño de Apple; este proyecto no está afiliado con Apple.
