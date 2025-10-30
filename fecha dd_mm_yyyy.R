
# Cargar las librerías
library(readxl)
library(dplyr)
library(lubridate) 
library(openxlsx)

# Ruta del archivo Excel
ruta_archivo <- "" # <--- Añadir la ruta de tu archivo

# Leer el archivo Excel
datos <- read_excel(ruta_archivo)

# Paso 1: Asegurarse de que la columna 'fecha' sea tratada como fecha por R.

if (inherits(datos$fecha, "numeric")) {
  # Si es numérica, asumimos que son días desde el origen de Excel
  datos <- datos %>%
    mutate(fecha = as.Date(fecha, origin = "1899-12-30"))
} else if (inherits(datos$fecha, "POSIXct") || inherits(datos$fecha, "Date")) {
  # Si ya es POSIXct (fecha y hora) o Date, simplemente la convertimos a Date para asegurar.
  datos <- datos %>%
    mutate(fecha = as.Date(fecha))
} else {
  # Si no es ninguno de los anteriores, podría ser un caracter que necesita ser parseado
  # Esto es una adición para robustez si las fechas no se importan limpiamente
  # Aquí necesitarías saber el formato original si es un caracter
  # Por ejemplo, si está como "DD-MM-YYYY":
  # datos <- datos %>%
  #   mutate(fecha = dmy(fecha)) # Requiere lubridate
  warning("La columna 'fecha' no es numérica, POSIXct ni Date. Intentando convertir a Date.")
  datos <- datos %>%
    mutate(fecha = as.Date(fecha)) # Esto podría fallar si el formato es muy irregular
}


# Paso 2: Formatear la columna 'fecha' a tipo caracter 'dd/mm/yyyy'
# Una vez que 'fecha' es un objeto 'Date' de R, podemos formatearla a una cadena de texto.
datos <- datos %>%
  mutate(fecha = format(fecha, "%d/%m/%Y"))

# --- Guardar el archivo Excel modificado ---
wb <- createWorkbook()
addWorksheet(wb, "Datos Modificados")
writeData(wb, "Datos Modificados", datos)

ruta_nuevo_archivo <- "" # <--- Añadir la ruta para el nuevo archivo con el formato nuevo
saveWorkbook(wb, ruta_nuevo_archivo, overwrite = TRUE)

# Mensaje de confirmación
cat(paste0("El archivo ha sido procesado y guardado en: ", ruta_nuevo_archivo, "\n"))
cat("La columna 'fecha' ha sido formateada a dd/mm/yyyy.\n")

# Para ver las primeras filas del dataframe modificado en la consola
print(head(datos))