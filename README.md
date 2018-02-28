# Disclaimer

Don't use this unless you are one with unix. Otherwise, you use at your own peril!

# What is?

Hey, `bash-merge` will merge sourced files into the parent script. Make sense?


# Usage
```bash
ENTRY=/absolute/path/to/parent-script \
 TARGET=relative/path/to/dist bash-merge
```

# Example
```bash
ENTRY=/users/ramos/repos/bash-merge/example-proj/main \
 TARGET=outfile bash-merge
```

# Note

* Currently, `bash-merge` supports only scripts that source files with a *relative* path.
* Not yet tested with nested sources
