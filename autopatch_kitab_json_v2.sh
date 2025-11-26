#!/usr/bin/env bash
set -euo pipefail

echo "==[ AUTOPATCH KITAB JSON v2.0 ]=="

JSON_DIR="json"
mkdir -p "$JSON_DIR"

INDEX_FILE="$JSON_DIR/index.json"
TMP_INDEX="$(mktemp)"

echo "[" > "$TMP_INDEX"

count=0

# Cari semua PDF di folder semasa (root repo)
while IFS= read -r -d '' file; do
  pdf_path="$file"
  pdf_name="$(basename "$file")"            # contoh: AMALAN HARI ASYURA 080822.pdf
  base_name="${pdf_name%.pdf}"              # tanpa .pdf

  # Buat ID: huruf kecil, space/underscore → dash, buang karakter pelik
  id="$(echo "$base_name" | tr '[:upper:]' '[:lower:]' | sed 's/[_ ]\+/-/g' | sed 's/[^a-z0-9-]//g')"

  # Nama paparan: ganti _ dan - dengan space (biar manusia senang baca)
  display_name="$(echo "$base_name" | sed 's/[_-]/ /g')"

  json_path="$JSON_DIR/$id.json"

  echo ">> Proses PDF: $pdf_name"
  echo "   - id   : $id"
  echo "   - json : $json_path"

  # Kalau JSON belum wujud, buat template
  if [ ! -f "$json_path" ]; then
    cat > "$json_path" << JSON
[
  {
    "id": 1,
    "kod": "$id",
    "tajuk": "Pendahuluan",
    "ms": 1,
    "arab": "",
    "terjemahan": "",
    "nota": "Isi akan diisi kemudian daripada kitab asli \\"$base_name\\"."
  }
]
JSON
    echo "   + Template JSON baru dibuat."
  else
    echo "   = JSON sudah wujud, TIDAK diubah."
  fi

  # Tambah entri ke index (dengan koma antara objek)
  if [ "$count" -gt 0 ]; then
    echo "," >> "$TMP_INDEX"
  fi

  cat >> "$TMP_INDEX" << JSON
  {
    "id": "$id",
    "nama": "$display_name",
    "kategori": "Belum dikategori",
    "json": "json/$id.json",
    "pdf": "$pdf_name"
  }
JSON

  count=$((count + 1))

done < <(find . -maxdepth 1 -type f -name '*.pdf' -print0)

echo "]" >> "$TMP_INDEX"

mv "$TMP_INDEX" "$INDEX_FILE"

echo
echo "Siap: $count PDF diproses."
echo "- Semua template JSON wujud dalam folder $JSON_DIR/"
echo "- Index utama: $INDEX_FILE (di-overwrite berdasarkan fail PDF semasa)."
echo "==[ SIAP AUTOPATCH 2.0 ]=="
