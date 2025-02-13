#!/bin/bash

# Install Docker
apt-get update
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
systemctl enable docker
systemctl start docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.17.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create Docker Compose file
mkdir -p /opt/sonarqube
cat << 'DOCKER_COMPOSE' > /opt/sonarqube/docker-compose.yml
version: "3.8"
services:
  sonarqube:
    image: sonarqube:${sonarqube_version}
    depends_on:
      - db
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: ${postgres_password}
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
    ports:
      - "9000:9000"
    networks:
      - sonarnet
    restart: unless-stopped
    ulimits:
      nproc: 65535
      nofile:
        soft: 65536
        hard: 65536

  db:
    image: postgres:${postgres_version}
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: ${postgres_password}
      POSTGRES_DB: sonar
    volumes:
      - postgresql:/var/lib/postgresql/data
    networks:
      - sonarnet
    restart: unless-stopped

networks:
  sonarnet:
    driver: bridge

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  postgresql:
DOCKER_COMPOSE

# Set required system settings for SonarQube
sysctl -w vm.max_map_count=262144
sysctl -w fs.file-max=65536
ulimit -n 65536
ulimit -u 4096

# Make system settings permanent
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
echo "fs.file-max=65536" >> /etc/sysctl.conf

# Start containers
cd /opt/sonarqube
docker-compose up -d
