# Typst manuscripts
A template repo to jumpstart writing typst manuscripts.

## How to use
- First, click on the button on the top-right to use this repository as your template.
- Second, install [the Typst compiler](https://github.com/typst/typst), and
  be sure that you can use `typst` from the command line.
- Go in the root of the (cloned) project and run:
  ```bash
  typst watch src/main.typ target/main.pdf --font-path src/resources/fonts --open 
  ```

This should open your default PDF viewer to preview your document as you type
(and save it).
The same command above can be found in `./compile` so you can just run that script.
You can find the finished, compiled output in `target/main.pdf`.

You're done!

### Template information
The template is for a pretty standard one-column paper manuscript.
You get pretty authors with OrcIDs, acronyms, bibliography, and more.

- To add new acronyms, edit the `src/resources/acronyms.typ` file.
- To change the bibliography, add them to `src/resources/refs.bib` in bibtex
  format.
- Add images into the `src/resources/images/` directory in any format you like.
- To hide the draft box after the abstract, pass `work_in_progress: false` at
  the start of `main.typ`.

## Font
This template bundles and uses by default the Atkinson Hyperlegible font.
It follows its own [license](src/resources/fonts/LICENSE), which you can read.
It only forbids selling *the font itself*. You are free to do anything you like
with a document that uses the font, including selling it or repackaging it.

Using the Atkinson Hyperlegible font helps people with partially impaired vision
read and enjoy your work. I also find it very pleasing on the eyes.
You can read more about the font (and download more copies) at
[https://brailleinstitute.org/freefont](https://brailleinstitute.org/freefont)

