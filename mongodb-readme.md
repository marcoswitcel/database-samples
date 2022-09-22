# Ajuda para acessar o container do MongoDB

```bash
# Após subir o container descubra o hash e acesso o bash do container, exemplo abaixo
sudo docker exec -it 4df /bin/bash
# Dentro do terminal do container execute o seguinte comando para acessar o
# cliente do banco com com as credenciais de acesso configuradas no arquivo docker-compose-mongodb.yml
mongosh --host localhost:27017 -p dio -u dio
```
