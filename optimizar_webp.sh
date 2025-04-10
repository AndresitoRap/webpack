#!/bin/bash

echo "🌿 Optimizando imágenes WebP en el proyecto..."

find . -name "*.webp" | while read img; do
  original_size=$(stat -f%z "$img")
  tmp="tmp_optimized.webp"

  cwebp -m 6 -metadata none -q 80 "$img" -o "$tmp"

  optimized_size=$(stat -f%z "$tmp")

  if [ "$optimized_size" -lt "$original_size" ]; then
    mv "$tmp" "$img"
    echo "✅ $img optimizada: $((original_size / 1024))KB → $((optimized_size / 1024))KB"
  else
    rm "$tmp"
    echo "⏭️  $img ya está optimizada (sin cambios)"
  fi
done

echo "🎉 ¡Optimización completada!"
