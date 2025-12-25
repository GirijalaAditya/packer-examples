source "file" "file-builder-ex" {
  content = " SHIVA OM NAMAHA SHIVAYA"
  target  = "file"
}

build {
  sources = ["source.file.file-builder-ex"]
}