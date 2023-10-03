# Usar Ubuntu 20.04 como base
FROM ubuntu:20.04

# Evitar preguntas de configuración durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar el sistema y instalar dependencias
RUN apt-get update -qq && \
    apt-get install -y build-essential perl cpanminus libhunspell-1.7-0 hunspell-en-us libhunspell-dev make gcc pkg-config

# Instalar módulos de Perl
RUN cpanm ExtUtils::PkgConfig && \
    cpanm File::Slurp && \
    cpanm Lingua::EN::Fathom && \
    cpanm Text::Hunspell

# Copiar el código fuente al contenedor
COPY . /app

# Configurar el entorno y los directorios
WORKDIR /app/Text-Hoborg 

RUN perl Makefile.PL

# Commando por defecto para ejecutar las pruebas
CMD make test
