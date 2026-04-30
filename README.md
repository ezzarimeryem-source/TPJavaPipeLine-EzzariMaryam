# TP JavaPipeLine — Ezzari Maryam

## 📌 Description

Ce TP consiste à mettre en place un pipeline CI/CD automatisé avec **Jenkins**, **Docker**, **Maven** et **GitHub Webhooks**. À chaque push sur le dépôt GitHub, le pipeline se déclenche automatiquement et exécute les étapes de build et de test du projet Java Maven.

---

## 🏗️ Architecture

```
GitHub (push) 
    ↓ webhook
ngrok (tunnel public)
    ↓
Jenkins (localhost:8080)
    ↓
Docker (agent maven)
    ↓
Build + Test Maven
```

---

## 🛠️ Technologies utilisées

| Outil | Rôle |
|---|---|
| Jenkins | Serveur CI/CD |
| Docker | Conteneurisation de Jenkins et de l'agent Maven |
| Maven | Build et test du projet Java |
| GitHub | Hébergement du code source |
| ngrok | Tunnel pour exposer Jenkins à GitHub |
| GitHub Webhook | Déclenchement automatique du pipeline |

---

## 📁 Structure du dépôt

```
TPJavaPipeLine-EzzariMaryam/
├── Jenkinsfile               # Script du pipeline CI/CD
├── Dockerfile                # Image Docker personnalisée Jenkins
├── Dockerfile.jenkins        # Dockerfile pour l'agent Maven
└── README.md                 # Ce fichier
```

---

## ⚙️ Jenkinsfile

```groovy
pipeline {
    agent {
        docker {
            image 'my-maven-git:latest'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    stages {
        stage('Checkout') {
            steps {
                sh "rm -rf *"
                sh "git clone https://github.com/simoks/java-maven.git"
            }
        }
        stage('Build') {
            steps {
                script {
                    def currentDir = pwd()
                    echo "Current directory: ${currentDir}"
                    dir('java-maven/maven') {
                        sh 'mvn clean test package'
                        sh "java -jar target/maven-0.0.1-SNAPSHOT.jar"
                    }
                }
            }
        }
    }
}
```

---

## 🚀 Étapes de mise en place

### 1. Lancement de Jenkins avec Docker

Jenkins a été lancé dans un conteneur Docker avec accès au socket Docker de la machine hôte :

```bash
docker run -d \
  --name jenkins \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  myjenkins-blueocean:latest
```

### 2. Construction de l'image Maven personnalisée

```bash
docker build -t my-maven-git:latest .
```

### 3. Configuration du Webhook GitHub avec ngrok

```bash
ngrok http 8080
```

Payload URL configurée sur GitHub :
```
https://molecule-sage-specks.ngrok-free.dev/github-webhook/
```

### 4. Configuration Jenkins

- Plugin **GitHub Integration** installé
- Trigger **"GitHub hook trigger for GITScm polling"** activé

---

## ✅ Résultats

| Build | Statut | Déclenchement |
|---|---|---|
| #1 à #5 | ❌ (configuration) | Manuel |
| #6 | ✅ Succès | Manuel |
| #7 | ✅ Succès | **Automatique via Webhook** |

---

## 📸 Captures d'écran

### 🐳 Docker — Conteneur Jenkins en cours d'exécution
`docker ps` confirme que le conteneur `myjenkins-blueocean:latest` tourne sur le port 8080.

<img width="1920" height="1080" alt="Screenshot 2026-04-30 073047" src="https://github.com/user-attachments/assets/5201bf98-4f6c-4cfe-8d73-0a21ef8aa618" />

---

### 🌐 ngrok — Tunnel actif avec requêtes 200 OK
ngrok v3.39.1 actif, forwarding vers localhost:8080. Les 2 requêtes POST /github-webhook/ ont reçu une réponse **200 OK**.

<img width="1920" height="1080" alt="Screenshot 2026-04-30 073010" src="https://github.com/user-attachments/assets/e39eeb67-424e-463d-bbf1-133929d61d41" />

---

### 🔗 GitHub Webhook — Livraisons réussies
Les livraisons GitHub montrent un ✅ vert sur l'événement `push` du 30/04/2026 — le webhook a bien déclenché Jenkins.

<img width="1920" height="1080" alt="Screenshot 2026-04-30 072936" src="https://github.com/user-attachments/assets/4c9856a7-06f3-470b-adbc-65ef5bf53915" />

---

### 🏗️ Jenkins — Historique des builds
Builds #6 et #7 sont verts ✅. Le build #7 a été déclenché automatiquement par le push GitHub.

<img width="1920" height="1080" alt="Screenshot 2026-04-30 072725" src="https://github.com/user-attachments/assets/1e42ed0e-3fc5-4a1d-a3a3-b0509e6be0f8" />

---

### 🎯 Jenkins Build #7 — Déclenché automatiquement par GitHub
Build #7 du 30 Apr 2026 — **"Started by GitHub push by ezzarimeryem-source"** — preuve du déclenchement automatique via webhook.

<img width="1920" height="1080" alt="Screenshot 2026-04-30 073622" src="https://github.com/user-attachments/assets/461841e5-c033-478a-aa2f-2490a638f929" />


---

## 👤 Auteur

**Ezzari Maryam**  
Dépôt : [TPJavaPipeLine-EzzariMaryam](https://github.com/ezzarimeryem-source/TPJavaPipeLine-EzzariMaryam)
