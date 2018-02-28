# Disclaimer

Don't use this unless you are one with unix. Otherwise, you use at your own peril!

# What is?

Hey, `bash-merge` will merge sourced files into the parent script. Make sense?


# Usage
```bash
ENTRY=/absolute/path/to/parent/script \
 TARGET=relative/path/to/ENTRY bash-merge
```

# Example
```bash
ENTRY=/users/ramos/repos/bash-merge/example-proj/main \
 TARGET=outfile bash-merge
```

# Note

* Currently, all sourced within the parent script are expected to be given as relative paths.
* Not yet tested with nested sources
