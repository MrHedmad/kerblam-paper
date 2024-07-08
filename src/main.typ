#import "template.typ": *
#show: project.with(
  title: "The Paper Title",
  authors: (
    (
      name: "John Doe",
      shortname: "J.D.",
      email: "john.doe@example.com",
      affiliation: "*",
      orcid: "0000-0000-0000-0000",
      corresponding: true
    ),
    (
      name: "Mary Doe",
      shortname: "M.D.",
      email: "mary.doe@example.com",
      affiliation: "**",
      orcid: "0000-0000-0000-0000",
      corresponding: false
    ),
  ),
  affiliations: (
    (id: "*", value: "Department of Science and Literature, University of Life, Earth, Milky Way"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: [
    #lorem(50)
  ],
  // Disable this once you are done
  work_in_progress: true
)

/*
--- A NOTE ABOUT FIGURES AND MULTICOLUMNS ---
A limitation in typst right now is that an environment cannot be broken.
For this reason, if text is in a #columns(...)[] environment you cannot place a
multi-column spanning figure in there (it will span just one column).

There is an issue tracking this addition:
https://github.com/typst/typst/issues/553

However, it seems that fixing it will be quite difficult for how typst currently works.
This is the reason why when a #figure is added, the columns environment is temporarily broken.
A side effect is that the text is broken where the figure is placed.
Layout will require manual intervention later on, once the text is all written.

This means that we don't use the column environment, but you could!
You just have to manually break the text around spanning figures with repeated
calls to `#columns(...)[]`.
*/

= Introduction

#lorem(100)

= Materials and Methods

#lorem(100)

= Discussion

#lorem(100)

/* Include Appendices
#pagebreak(weak: true)
#set heading(numbering: "A.1", supplement: "Appendix")
#counter(heading).update(0)
= Appendix
#lorem(50)
== Appendix
#lorem(50)

*/

/* Include Supplementary
#pagebreak(weak: true)
#set heading(numbering: "A.1", supplement: "Supplementary")
#counter(heading).update(0)
= Supplementary information
#lorem(50)
*/

#pagebreak()
#bibliography("resources/refs.bib", style: "resources/nature-no-superscript-square.csl")
