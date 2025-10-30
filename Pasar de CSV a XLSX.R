# Cargar las librerías necesarias
library(readr)  # Para leer archivos CSV
library(writexl) # Para escribir archivos XLSX

# 1. Especificar las rutas de los archivos
csv_file <- ""# Reemplaza con la ruta a tu archivo CSV
xlsx_file <- ""  # Reemplaza con la ruta donde guardar el XLSX

# 2. Leer el archivo CSV
datos <- read_csv(csv_file)

# 3. Escribir los datos en un archivo XLSX
write_xlsx(datos, xlsx_file)

# Opcional: Si quieres nombrar la hoja dentro del archivo XLSX
# write_xlsx(datos, xlsx_file, sheet = "NombreDeLaHoja")


