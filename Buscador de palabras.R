# --- Script para Buscar Palabras Clave en Nombres de Columnas de un Archivo XLSX ---

# Paso 1: Cargar paquetes (instalarlos si no los tienes)
# install.packages("readxl") # Para leer archivos Excel
# install.packages("dplyr")  # Para manipulación de datos 

# Paso2: Cargamos las librerias
library(readxl)
library(dplyr)



# 1. Ruta y nombre de tu archivo Excel de entrada
input_file_path <- "" # <--- Añadir la ruta de tu archivo

# 2. Nombre de la hoja de cálculo a procesar 
sheet_name <- "" # <--- Nombre de la hoja con la que vamos a trabajar



# --- Lógica del Script ---

message("Iniciando la búsqueda de palabras clave en los nombres de las columnas...")

# Paso 1: Cargar el archivo XLSX (solo los nombres de las columnas)
# Usamos range = "A1" para leer solo la primera fila (los encabezados)
# y col_names = TRUE para que los use como nombres de columna.
# col_types = "text" para leer todo como texto, evitando problemas de interpretación.
message(paste("Intentando leer los nombres de las columnas del archivo:", input_file_path, "en la hoja:", sheet_name))
tryCatch({
  # Lee solo la primera fila para obtener los nombres de las columnas
  df_headers <- read_excel(input_file_path, sheet = sheet_name, range = "A1", col_names = TRUE, col_types = "text")
  column_names <- colnames(df_headers)
  message("Nombres de columnas obtenidos exitosamente.")
}, error = function(e) {
  stop(paste("Error al cargar los nombres de las columnas. Verifica la ruta/nombre del archivo y la hoja.\nError: ", e$message))
})

# Palabras clave a buscar
keyword1 <- "" # <--- palabras que vamos a buscar
keyword2 <- "visualizacion" # <--- palabras que vamos a buscar

# Paso 2: Buscar las palabras clave en los nombres de las columnas
# Convertimos los nombres de las columnas a minúsculas para una búsqueda insensible a mayúsculas/minúsculas
column_names_lower <- tolower(column_names)

# Columnas que contienen "perfil"
columns_with_perfil <- column_names[grepl(keyword1, column_names_lower)]

# Columnas que contienen "visualizacion"
columns_with_visualizacion <- column_names[grepl(keyword2, column_names_lower)]

# Paso 3: Mostrar los resultados
message("\n--- RESULTADOS DE LA BÚSQUEDA ---")

if (length(columns_with_perfil) > 0) {
  message(paste("Se encontraron columnas con la palabra '", keyword1, "':", sep = ""))
  for (col in columns_with_perfil) {
    message(paste("- ", col))
  }
} else {
  message(paste("No se encontraron columnas con la palabra '", keyword1, "'.", sep = ""))
}

message("-------------------------------")

if (length(columns_with_visualizacion) > 0) {
  message(paste("Se encontraron columnas con la palabra '", keyword2, "':", sep = ""))
  for (col in columns_with_visualizacion) {
    message(paste("- ", col))
  }
} else {
  message(paste("No se encontraron columnas con la palabra '", keyword2, "'.", sep = ""))
}

message("\nBúsqueda completada.")