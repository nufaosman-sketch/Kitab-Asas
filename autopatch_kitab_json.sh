#!/usr/bin/env bash
set -euo pipefail

echo "==[ AUTOPATCH KITAB JSON ]=="

# Pastikan folder json wujud
mkdir -p json

########################################
# 1) Wiridulathif BM RS
########################################
cat > json/wiridulathif-bm-rs.json << 'JSON'
[
  {
    "id": 1,
    "kod": "wiridulathif-bm-rs",
    "tajuk": "Pendahuluan",
    "ms": 1,
    "arab": "",
    "terjemahan": "",
    "nota": "Isi akan diisi kemudian berdasarkan kitab Wiridulathif BM RS."
  }
]
JSON

########################################
# 2) Terjemahan Nirudzzolam
########################################
cat > json/terjemahan-nirudzzolam.json << 'JSON'
[
  {
    "id": 1,
    "kod": "terjemahan-nirudzzolam",
    "tajuk": "Pendahuluan",
    "ms": 1,
    "arab": "",
    "terjemahan": "",
    "nota": "Isi akan diisi kemudian berdasarkan kitab Terjemahan Nirudzzolam."
  }
]
JSON

########################################
# 3) Amalan Hari Asyura 080822
########################################
cat > json/amalan-hari-asyura-080822.json << 'JSON'
[
  {
    "id": 1,
    "kod": "amalan-hari-asyura-080822",
    "tajuk": "Pendahuluan",
    "ms": 1,
    "arab": "",
    "terjemahan": "",
    "nota": "Isi akan diisi kemudian berdasarkan kitab Amalan Hari Asyura 080822."
  }
]
JSON

########################################
# 4) Index semua kitab
########################################
cat > json/index.json << 'JSON'
[
  {
    "id": "wiridulathif-bm-rs",
    "nama": "Wiridulathif BM RS",
    "kategori": "Wirid & Zikir",
    "json": "json/wiridulathif-bm-rs.json",
    "pdf": "Wiridulathif BM RS.pdf"
  },
  {
    "id": "terjemahan-nirudzzolam",
    "nama": "Terjemahan Nirudzzolam",
    "kategori": "Kitab Tauhid / Akidah (Terjemahan)",
    "json": "json/terjemahan-nirudzzolam.json",
    "pdf": "Terjemahan Nirudzzolam.pdf"
  },
  {
    "id": "amalan-hari-asyura-080822",
    "nama": "Amalan Hari Asyura 080822",
    "kategori": "Amalan / Wirid Harian",
    "json": "json/amalan-hari-asyura-080822.json",
    "pdf": "AMALAN HARI ASYURA 080822.pdf"
  }
]
JSON

echo "Siap: semua template JSON & index.json dibuat dalam folder json/"
