# Terraform Proyecto de Infraestructura Personal

Este proyecto usa **Terraform** para gestionar y desplegar varios servicios de AWS en un entorno automatizado y controlado por código.

---

## 🚀 Servicios desplegados hasta el momento

### ✅ Amazon Cognito
- **User Pool** con políticas de recuperación, autenticación y seguridad.
- **User Pool Client** con OAuth2 (`code`, `email`, `openid`, `phone`).
- Cliente listo para integrarse con frontend (Next.js, por ejemplo).

### ✅ AWS Budgets
- Presupuesto mensual de **$1.00 USD**
- Notificaciones por email si se supera el umbral de uso.

### ✅ Amazon RDS (MySQL)
- Instancia **MySQL 8.0** en capa gratuita (`db.t3.micro`)
- Grupo de subred y grupo de seguridad configurados.
- Totalmente gestionado vía Terraform.
- Pronto: integración con Lambda para ejecutar script SQL (`init.sql`).

---

## 🧱 Estructura de archivos

```bash
terraformProyect/
├── main.tf                # Provider AWS
├── cognito.tf             # Recursos de Cognito
├── budget.tf              # Presupuesto AWS
├── rds.tf                 # Subnet group + instancia MySQL
├── outputs.tf             # (opcional) para exponer variables útiles
├── .terraform/            # Caché de plugins (ignorado en git)
├── terraform.tfstate      # Estado de la infraestructura
└── .gitignore             # Exclusión de archivos innecesarios
```

---

## 🛠️ Comandos utilizados

### Inicializar Terraform
```bash
terraform init
```

### Ver cambios sin aplicar (plan)
```bash
terraform plan
```

### Aplicar todo el proyecto
```bash
terraform apply
```

### Aplicar solo un recurso (ej. base de datos)
```bash
terraform apply -target=aws_db_instance.mysql
```

### Destruir toda la infraestructura
```bash
terraform destroy
```

### Destruir solo la base de datos
```bash
terraform destroy -target=aws_db_instance.mysql -target=aws_db_subnet_group.mysql_subnet_group
```

---

## 📌 Recomendaciones de uso

- ⚠️ No subir el archivo `terraform.tfstate` a Git, contiene datos sensibles.
- Usa `terraform plan` antes de cada `apply`.
- Si estás usando la capa gratuita, monitorea tu uso con AWS Budgets para evitar cobros.
- El archivo `init.sql` se integrará pronto con una función Lambda.

---

## 📦 Pendientes / Roadmap

- [ ] Crear Lambda para ejecutar `init.sql` desde S3 sobre RDS
- [ ] Automatizar despliegue completo con módulos o workflows
- [ ] Dividir recursos en módulos reutilizables

---

## 🧠 Autor

Proyecto personal de infraestructura desarrollado por **Breiner**.  
Este repositorio demuestra buenas prácticas de infraestructura como código (IaC) con Terraform sobre AWS.
