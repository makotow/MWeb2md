# MWeb2Markdown


## What is this?

Very simple tool which is converting to MWeb to Markdown format tool.

## Requirements

- Ruby

## Current features

- simple migrate to MWeb to markdown
- Change image path in markdown file.

## How to use?

```
$ ./mweb2md.rb --help
-l, --mweb-lib-path=MWEBLIBPATH  MWeb Library Path
-s, --src-article=FILENAME       target markdown file
-d, --dest-article-dir=DIR       directory mweb format to general markdown
```

```Examples
$ mweb2md -l mweb_library_path -s source_dir/markdownfile -d dest_dir
```

The following is typical cli example.
```
p./mweb2md.rb -l ~/Lib/MWebLibrary/docs -s 15024616520518.md -d ./test/test01/
```

## TODO

TBD

## Authors

- [@makotow](https://github.com/makotow)

## License

MIT
