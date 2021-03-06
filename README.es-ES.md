# Módulo Terraform para Alicloud Container Registry
Módulo Terraform para crear un Registro de Contenedores Docker privado (namespace) y un usuario RAM con permisos para
hacer push/pull al namespace creado.

**NOTA:** Este módulo usa _AccessKey_ y _SecretKey_ del `profile` y del `shared_credentials_file`. Si no los has
definido todavía, por favor instala [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) y configúralo.

***Disponible en otros idiomas:*** [English](https://github.com/roura356a/terraform-alicloud-cr/blob/master/README.md),
[Español](https://github.com/roura356a/terraform-alicloud-cr/blob/master/README.es-ES.md),
[简体中文](https://github.com/roura356a/terraform-alicloud-cr/blob/master/README.zh-CN.md).

----------------------


## Arquitectura del Módulo
Tras usar este módulo, los siguientes recursos serán creados:

![terraform-alicloud-cr diagram](https://raw.githubusercontent.com/roura356a/terraform-alicloud-cr/master/diagram.png "Module Diagram")


## Uso
```hcl
provider "alicloud" {}

module "cr" {
  source  = "roura356a/cr/alicloud"
  version = "1.3.0"
  
  namespace = "cr_repo_namespace"
}
```

Tras ejecutar `terraform apply`, un fichero llamado `cr-{namespace}-ak.json` será generado con el _AccessKey_ y
_SecretKey_ necesarios para llamar el API de `cr` `GetAuthorizationToken` y así poder hacer push/pull a los repositorios
dentro del namespace creado.


### Entradas
| Nombre | Descripción | Tipo | Valor por defecto | Requerido |
|------|-------------|------|---------|----------|
| region | La región usada para lanzar los recursos definidos por el módulo | string | "" | no |
| profile | El nombre del perfil como aparece en el archivo `credentials`. Si no se proporciona, el valor será leído de la variable de entorno `ALICLOUD_PROFILE` | string | "default" | no |
| shared_credentials_file | La ruta al archivo `credentials`. Si no se proporciona y un perfil ha sido especificado, se asumirá `$HOME/.aliyun/config.json` como valor | string | "" | no |
| skip_region_validation | Omitir validación estática de la región. Usada por usuarios que tienen acceso a regiones privadas o regiones que usan APIs compatibles con Alibaba Cloud | bool | false | no |
| namespace | Nombre del namespace para crear en el Registro de Contenedores | string | - | sí |
| repositories | Lista opcional de repositorios para ser creados al lanzar | list(string) | ["default"] | no |
| repo_autocreate | Booleana, cuando se asigne `true`, los repositorios podrán ser creados al vuelo cuando se use docker push con nuevas imágenes | bool | true | no |

Puedes crear repositorios simplemente con proporcionar una lista de strings con la variable `repositories`.


### Salidas
| Nombre | Descripción |
|------|-------------|
| cr_namespace | El Namespace creado |
| cr_access_key | El AccessKey para el namespace de CR |
| cr_user | El usuario creado para el namespace de CR |
| cr_endpoint | Dominio público del Registro de Contenedores |
| ram_user | El usuario RAM creado |
| ram_policy_name | El nombre de la póliza RAM |
| repository_ids | Lista de posibles repositorios creados |
| ram_console_username | Username para la consola |
| disposable_password | Contraseña temporal para activar el usuario en la consola, fuerza a resetearla |
| access_key_status | Estado de la llave creada |
| ram_policy_type | El tipo de la póliza RAM |
| ram_policy_attachments | El número de veces que la póliza ha sido adjuntada |


### Docker Login
Con el fin de activar el recién creado usuario RAM en el Registro, sólo la primera vez y por razones de seguridad,
Alibaba Cloud pide (esto puede cambiar en el futuro) que naveges a la
[Consola del Registro de Contenedores](https://cr.console.aliyun.com/) usando el nuevo usuario RAM con la contraseña
"one-time" que `terraform apply` genera como `disposable_password`, sigue las instrucciones que aparecen en pantalla
para activar el usuario.

Tras ello, con las credenciales del archivo `cr-{namespace}-ak.json`, puedes conseguir, usando el SDK `aliyun-cli`, un
login seguro temporal ejecutando `aliyun cr GetAuthorizationToken`.


## Versión de Terraform
Terraform version 0.12.0+ es requerida para que funcione este módulo.


## Autores
Creado y maintenido por Alberto Roura ([@roura356a](https://github.com/roura356a),
[albertoroura.com](https://albertoroura.com/)). Contribuye si quieres.


## Ejemplos
- [Básico](https://github.com/roura356a/terraform-alicloud-cr/tree/master/examples/basic)


## Testeando
Este módulo de Terraform usa [terratest](https://github.com/gruntwork-io/terratest) para testear los recursos IaC
creados. Para testear, entra en la carpeta `test`, corre `go mod init cr`, `go mod tidy` y luego `go test`.


## Licencia
Licencia Apache 2. Abre [LICENSE](https://github.com/roura356a/terraform-alicloud-cr/tree/master/LICENSE) para más
detalles.


## Referencias
* [Terraform Alicloud Provider Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform Alicloud Provider Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform Alicloud Provider Docs](https://www.terraform.io/docs/providers/alicloud/)
