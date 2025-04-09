 MÓDULO DE COGNITO - INFRAESTRUCTURA AWS CON TERRAFORM
=========================================================

Descripción del servicio:
--------------------------
Amazon Cognito es un servicio de autenticación y gestión de usuarios 
proporcionado por AWS. Permite añadir registro, inicio de sesión, 
recuperación de contraseñas y autenticación segura a aplicaciones web 
y móviles. Cognito se integra fácilmente con aplicaciones modernas y 
ofrece soporte para autenticación basada en tokens (OAuth 2.0, OpenID Connect).

Con Cognito puedes:
- Crear y administrar grupos de usuarios (User Pools)
- Configurar flujos de inicio de sesión y recuperación de cuentas
- Integrar la autenticación con frontend (como aplicaciones React o móviles)
- Aplicar políticas de contraseñas y validación
- Emitir y validar tokens de acceso, ID y refresh
- Soportar login social o federado (Google, Facebook, etc.)

Este módulo aprovecha las capacidades de Cognito para crear una base
segura de autenticación de usuarios, lista para integrarse con un
frontend como una aplicación en React o Next.js.

Recursos que se crean:
----------------------
1. aws_cognito_user_pool (user_pool)
   - Nombre del pool: User pool - u5spfn
   - Autoverificación de correos electrónicos
   - MFA (autenticación multifactor): desactivado
   - Protección contra eliminación: activa (ACTIVE)
   - Recuperación de cuentas configurada (email y teléfono)
   - Reglas de contraseñas fuertes
   - Atributo obligatorio: email

2. aws_cognito_user_pool_client (user_pool_client)
   - Nombre: react-nextjs-users
   - Asociado al user pool creado
   - Flujo de autenticación configurado: SRP, USER_PASSWORD, REFRESH_TOKEN
   - Scopes de OAuth habilitados: email, openid, phone
   - URL de retorno para autenticación: CloudFront u otra URL frontend
   - Tokens con tiempos de validez personalizados
   - Protección contra errores de existencia de usuario: activada
   - Revocación de token habilitada

Uso del módulo:
---------------
Este módulo se puede utilizar desde el archivo principal `main.tf`:

module "cognito" {
  source = "./cognito"
}

Variables:
----------
Actualmente este módulo no necesita variables externas.
Se puede mejorar para parametrizar:
- Nombre del pool
- Nombre del cliente
- URL de retorno
- Scopes permitidos
- Configuración de OAuth

Outputs sugeridos:
------------------
Para aprovechar datos del módulo desde el root:

output "user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}

Resumen técnico:
----------------
- Región de despliegue: us-east-2
- Backend frontend-ready con OAuth2
- Ideal para aplicaciones SPA o móviles
- Preparado para expansión futura (autenticación federada)

Autor:
------
Breiner Andrés Rojas  
Proyecto Universitario - Terraform y AWS
