FROM maven:3.9.6-eclipse-temurin-17

# Installer git (souvent absent de l'image Maven de base)
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
