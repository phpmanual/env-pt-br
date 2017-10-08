# env-pt-br

:smile: Set up your environment and start to contribute with PHP Manual (translation into pt_BR Brazilian Portuguese)

## Why

Because contributing with PHP Manual demands some "boring" steps, and having a way to automate this process is awesome.

So **phpmanual/env-pt-br** project provides this: a `Makefile` that gives you this automation!

*Note: This one is specific for working on pt_BR Brazilian Portuguese translation. Checkout <https://github.com/phpmanual> for other available setups, or create your one based on those*

## Colinha, em português!

[cola.md](cola.md)

## Usage

```
export your_desired_folder=~/php-manual-pt-br # change accordingly
git clone https://github.com/phpmanual/env-pt-br.git $your_desired_folder
cd $your_desired_folder
make
```

... so choose the action!

### Examples

#### make init

[![asciicast](https://asciinema.org/a/44199.png)](https://asciinema.org/a/44199)
Asciinema: <https://asciinema.org/a/44199>

#### make sync

[![asciicast](https://asciinema.org/a/44221.png)](https://asciinema.org/a/44221)
Asciinema: <https://asciinema.org/a/44221>

#### make build

[![asciicast](https://asciinema.org/a/44201.png)](https://asciinema.org/a/44201)
Asciinema: <https://asciinema.org/a/44199>

#### make web

[![asciicast](https://asciinema.org/a/44206.png)](https://asciinema.org/a/44206)
Asciinema: <https://asciinema.org/a/44199>