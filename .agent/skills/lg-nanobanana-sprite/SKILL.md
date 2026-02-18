# 🍌 Liquid Galaxy Nano Banana Sprite Master (`lg-nanobanana-sprite`)

## 📋 Directive Overview
This skill acts as the **Technical Art Director** for your Flutter Controller. It transforms AI text prompts (Nano Banana / Imagen) into high-fidelity, transparent game sprites (ships, markers, POIs) and integrates them into the Liquid Galaxy rig via **KML Overlays**.

**The Challenge:**  
Generative AI struggles to export clean Alpha channels (true transparency).

**The Solution:**  
Force the AI to generate a Hollywood-style **Green Screen** background, then use a Dart utility in `lib/core/utils/` to mathematically strip the green—outputting a perfect transparent PNG ready for KML injection via SSH.

---

## 🎨 Phase 1: The Green Screen Generation Protocol

Vagueness equals unusable assets. You must **strictly adhere** to this prompt structure so the Dart Chroma Key algorithm can isolate the sprite.

### The Immutable Prompt Template
> Top-down view of a **[Aesthetic, e.g., Sleek Cyberpunk]** **[Object, e.g., Spacecraft]**.  
> Feature: **[Specific Details, e.g., glowing blue thruster]**.  
> Background: **Solid bright neon green (#00FF00)**.  
> High contrast, symmetrical, isolated 2D game asset, 4k resolution.  
> The object must occupy the dead center of the frame.  
> **No checkerboard, no grid lines, no shadows on the ground.**

### Why Neon Green? 💚
Neon green is mathematically distinct from typical sci-fi and cartographic assets.  
This makes pixel isolation in Dart **lightweight, deterministic, and accurate**.

---

## 💻 Phase 2: Dart Chroma Key Utility (Core Layer)

To process these assets for the Rig, the student must implement a **Sprite Processor utility** inside the Flutter app.

**Instruction:**  
Add the `image` package to `pubspec.yaml`, then create the following file.

```dart
// File: lib/core/utils/sprite_processor.dart
import 'package:image/image.dart' as img;
import 'dart:typed_data';

class SpriteProcessor {
  /// Removes bright green backgrounds from AI-generated assets.
  /// Returns a transparent PNG byte array ready for SFTP upload to the Rig.
  static Uint8List removeGreenScreen(Uint8List rawImageBytes) {
    final image = img.decodeImage(rawImageBytes);
    if (image == null) {
      throw Exception('Failed to decode image');
    }

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixel(x, y);

        final r = pixel.r;
        final g = pixel.g;
        final b = pixel.b;

        // Chroma Key: Target bright neon green
        if (g > 150 && r < 100 && b < 100) {
          image.setPixelRgba(x, y, r, g, b, 0);
        }
      }
    }

    // Encode back to PNG to preserve alpha channel
    return img.encodePng(image);
  }
}
