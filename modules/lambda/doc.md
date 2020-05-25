## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| cloudwatch\_log\_group\_description | Description of the CloudWatch Log Group | `string` | `"Cloudfront log group for Lambda"` | no |
| cloudwatch\_retention\_days | Number of days to keep logs in cloudwatch. Default 30 | `number` | `30` | no |
| concurrency | Amount of reserved  concurrent executions, 0 desable lambda from being triggered, -1 no limitation. Default -1 | `number` | `-1` | no |
| description | A description of the function | `string` | n/a | yes |
| env | Lambda environment variables. Default: {} | `map(string)` | `{}` | no |
| environment | Environment | `string` | n/a | yes |
| filename | The path of the function's deployment package. | `string` | n/a | yes |
| handler | Code entrypoint. (function name usually) | `string` | n/a | yes |
| kms\_key\_arn | The ARN for the KMS encryption key. | `string` | `""` | no |
| lambda\_alias | Alias name of lambda latest version. | `string` | `"PROD"` | no |
| lambda\_layers | List of lambda layer version ARN. length(lambda\_layers) <= 5 | `list(string)` | `[]` | no |
| memory | Amount of memory in MB lambda can use at runtime. Default: 128 | `number` | `128` | no |
| product\_name | Short application name | `string` | n/a | yes |
| provided\_role | This flag ditermine whether `role_arn is provided or not `. Default: false | `string` | `false` | no |
| role\_arn | Lambda Execution role ARN attached to lambda, if empty basic execution role is created. Default: empty | `string` | `""` | no |
| role\_policy\_arns | List of policy ARN to attach to lambda execution role. Default: [] | `list(string)` | `[]` | no |
| role\_policy\_count | Number of policies to attach to lambda execution role (Required if role\_policy\_arns is provided). Default: 0 | `number` | `0` | no |
| runtime | Execution runtime (See https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) | `any` | n/a | yes |
| security\_group\_ids | List of security groups for lambda VPC config. Default: [] | `list(string)` | `[]` | no |
| short\_description | A short description without spaces and letters or - | `string` | n/a | yes |
| source\_arns | The ARNs of the resources whoservices who is getting the permissions to invoke the lambda. Default [] | `list(string)` | `[]` | no |
| source\_code\_hash | Check base64-encoded sha256 of the package to trigger updates. Default: false | `bool` | `false` | no |
| source\_services | The services who is getting the permissions to invoke the lambda. Default [] | `list(string)` | `[]` | no |
| tags | A list of tags to apply to resources that handles it | `map(string)` | n/a | yes |
| timeout | Max execution time in seconds. Default: 3 | `number` | `3` | no |
| tracing\_config | Tracing settings of the function. Default: PassThrough | `string` | `"PassThrough"` | no |
| vpc\_subnet\_ids | List of subnets for lambda VPC config. Default: [] | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| alias\_arn | The ARN of the lambda alias. |
| alias\_invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway |
| alias\_name | The ARN of the lambda alias name. |
| arn | The ARN identifying created lambda function. |
| invoke\_arn | The ARN to be used for invoking Lambda Function from API Gateway, CW Events..etc |
| lambda\_name | The name of created lambda function. |
| last\_modified | The date this resource was last modified. |
| log\_group\_arn | Log Group ARN. |
| log\_group\_name | Log Group Name. |
| qualified\_arn | The ARN identifying created lambda function version. |
| source\_code\_hash | Base64-encoded representation of raw SHA-256 sum of the lambda file. |
| source\_code\_size | The size in bytes of the function .zip file. |
| version | Latest published version of the lambda function. |

