![License](https://img.shields.io/badge/license-MIT-green)
# 🐳 docker-init-php | **One-Click Docker para Projetos PHP**  

**Automatize a dockerização de projetos PHP** com um único comando! Configura containers para Nginx, PHP-FPM (com Xdebug) e personalização de versões.  

👉 *"Encontrei um projeto PHP antigo? `docker-init` e *voilà*: ambiente pronto em segundos!"*  

---

## 🚀 **Como Usar**  

### 1. Execute o script:  
```bash  
chmod +x exec.sh  # Dê permissão  
./exec.sh         # Inicie o assistente  
```  

### 2. Responda às perguntas:  
- **Nome do projeto** (usado nos containers)  
- **Versão do PHP** (7.4, 8.0, 8.2, etc.)  
- **Pasta do código** (ex: `./src` ou `.` para raiz)  

### 3. Pronto! Seu ambiente será gerado com:  
```  
.  
├── docker-compose.yml  # Configuração dos serviços  
├── docker/  
│   ├── Dockerfile      # PHP-FPM + Xdebug  
│   └── nginx/  
│       └── nginx.conf  # Virtual host configurado  
```  

---

## 🌟 **Features**  

- ✅ **Suporte a múltiplas versões do PHP** (7.4+, com Xdebug automático para PHP 7.4)  
- ✅ **Nginx pré-configurado** (proxy reverso para PHP-FPM)  
- ✅ **Geração automática de arquivos** (sem editar manualmente!)  
- ✅ **Portas não conflitantes** (evita dor de cabeça com outros containers)  

---

## ⚙️ **Estrutura do `docker-compose.yml` Gerado**  

```yaml  
version: '3'  
services:  
  php:  
    build: ./docker  
    volumes:  
      - .{{project-folder}}:/var/www/html  # Pasta do projeto mapeada  
  nginx:  
    image: nginx:latest  
    ports:  
      - "80:80"  
    volumes:  
      - ./docker/nginx:/etc/nginx/conf.d  
      - .{{project-folder}}:/var/www/html  
```  

*(O script substitui `{{project-folder}}` dinamicamente!)*  

---

## 📌 **Exemplo Prático**  

### Para um projeto Laravel na pasta `src`:  
```bash  
$ cd {{pasta-do-projeto}}
$ ./{{pasta-do-git-init}}/exec.sh  
> Project name: [meu-laravel]  
> PHP version: [8.2]  
> Project code: [src]  
```  

Resultado:  
- Acesse o projeto em `http://localhost`  
- Xdebug desativado (para PHP 8.2+)  

---

## 🛠️ **Personalização Avançada**  

### Quer adicionar MySQL?  
Edite o `docker-compose.yml` gerado e adicione:  
```yaml  
services:  
  db:  
    image: mysql:5.7  
    environment:  
      MYSQL_ROOT_PASSWORD: root  
```  

---

## ❓ **FAQ**  

### ▶️ Como mudar a porta do Nginx?  
Edite o `docker-compose.yml` e substitua `"80:80"` por `"8080:80"`.  

### ▶️ Como ativar Xdebug em PHP 8+?  
Modifique o `Dockerfile` e adicione:  
```dockerfile  
RUN pecl install xdebug && docker-php-ext-enable xdebug  
```  

---

## 🤝 **Como Contribuir**  
1. Dê um **Fork** no projeto  
2. Crie um branch: `git checkout -b minha-feature`  
3. Commit suas mudanças: `git commit -m "Adicionei suporte a PostgreSQL"`  
4. Envie o branch: `git push origin minha-feature`  
5. Abra um **Pull Request**!  

---

## 📜 **Licença**  
MIT - Use, modifique e compartilhe livremente!  
