# Environment Variables Example

Demonstrates how to specify that your script supports (or requires) certain environment variables. This can be configured at any command level (root command or sub commands).

-----

## `bashly.yml`

```yaml
name: cli
help: Sample application that requires environment variables
version: 0.1.0

# This option adds usage text to the help message in the generated script.
environment_variables:
- name: api_key
  help: Set your API key

commands:
- name: verify
  short: v
  help: Verify your user

  # This option belongs to the `verify` command and will appear in its help
  # message.
  environment_variables:
  # Setting `required: true` will halt the script's execution with a
  # friendly error message, unless the variable is set.
  - name: my_secret
    help: Your secret
    required: true
  
  # Using the `default: value` option will cause the value to variable to be 
  # set if it is not provided by the user.
  - name: environment
    help: One of development, production or test
    default: development
```

## Generated script output

### `$ ./cli`

```shell
cli - Sample application that requires environment variables

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  verify   Verify your user



```

### `$ ./cli -h`

```shell
cli - Sample application that requires environment variables

Usage:
  cli [command]
  cli [command] --help | -h
  cli --version | -v

Commands:
  verify   Verify your user

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  API_KEY
    Set your API key



```

### `$ ./cli verify -h`

```shell
cli verify - Verify your user

Shortcut: v

Usage:
  cli verify
  cli verify --help | -h

Options:
  --help, -h
    Show this help

Environment Variables:
  MY_SECRET (required)
    Your secret

  ENVIRONMENT
    One of development, production or test
    Default: development



```

### `$ ./cli verify`

```shell
missing required environment variable: MY_SECRET


```

### `$ MY_SECRET="there is no spoon" ./cli verify`

```shell
# this file is located in 'src/verify_command.sh'
# code for 'cli verify' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none
environment:
- API_KEY=
- ENVIRONMENT=development
- MY_SECRET=there is no spoon


```

### `$ ENVIRONMENT=production MY_SECRET=safe-with-me ./cli verify`

```shell
# this file is located in 'src/verify_command.sh'
# code for 'cli verify' goes here
# you can edit it freely and regenerate (it will not be overwritten)
args: none
environment:
- API_KEY=
- ENVIRONMENT=production
- MY_SECRET=safe-with-me


```



