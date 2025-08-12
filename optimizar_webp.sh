#!/bin/bash

echo "🔄 Convirtiendo PNG → WebP y optimizando..."

# 1. Convertir PNG a WebP y borrar PNG original
find . -type f -name "*.png" | while read img; do
  webp="${img%.png}.webp"
  cwebp -m 6 -metadata none -q 80 "$img" -o "$webp"
  echo "🆕 Convertido: $img → $webp"
  rm "$img"
done

# 2. Optimizar todos los WebP
find . -type f -name "*.webp" | while read img; do
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

echo "🎉 Conversión y optimización completadas!"
