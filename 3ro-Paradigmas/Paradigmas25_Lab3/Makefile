# Configuración de Java - Fuerza Java 11 explícitamente
JAVA_HOME := /usr/lib/jvm/java-11-openjdk-amd64
JAVAC := $(JAVA_HOME)/bin/javac
JAVA := $(JAVA_HOME)/bin/java

# Configuración del proyecto
PROJECT_DIR := $(shell pwd)
OUT_DIR := $(PROJECT_DIR)/out
SRC_DIR := $(PROJECT_DIR)/src/main/java
RESOURCES_DIR := $(PROJECT_DIR)/src/main/resources
LIB_DIR := $(RESOURCES_DIR)/lib

# Spark (configurable al invocar make)
SPARK_FOLDER ?= /opt/spark

# Classpath - solución para wildcards
# Primero encuentra todos los .jar necesarios
LIB_JARS := $(shell find $(LIB_DIR) -name '*.jar' | tr '\n' ':')
SPARK_JARS := $(shell find $(SPARK_FOLDER)/jars -name '*.jar' | tr '\n' ':')
CLASSPATH := $(OUT_DIR):$(LIB_JARS)$(SPARK_JARS)$(RESOURCES_DIR)

# Archivos fuente y clase principal
SOURCES := $(shell find $(SRC_DIR) -name "*.java")
MAIN_CLASS := FeedReaderMain

# Targets
all: clean build run

build:
	@echo "Compilando con Java 11..."
	$(JAVAC) -Xlint:-options -source 11 -target 11 -cp "$(CLASSPATH)" -d $(OUT_DIR) $(SOURCES)

run:
	@echo "Ejecutando..."
	$(JAVA) -cp "$(CLASSPATH)" $(MAIN_CLASS) $(ARGS)

clean:
	@echo "Limpiando..."
	rm -rf $(OUT_DIR)

check-java-version:
	@echo "Verificando versión de Java..."
	@$(JAVA) -version
	@$(JAVAC) -version

.PHONY: all build run clean check-java-version