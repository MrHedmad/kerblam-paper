#import "@preview/acrostiche:0.3.1": * // acronyms
#import "resources/acronyms.typ": my_acronyms
//#import "@preview/wordometer:0.1.2": word-count, total-words

// Functions
#let icon(path) = {
  box(move(image(path, height: 0.5em), dy:-0.3em))
}

#let todo(stuff) = {
  set text(fill: red, weight: "bold")
  stuff
}

#let pageref(labelText) = {
  locate(loc => {
    let label = label(labelText)
    let elems = query(selector(label), loc)

    if elems.len() == 1 {
      let loc = elems.at(0).location()
      let pageNumber = counter(page).at(loc)
      link(label, numbering(loc.page-numbering(), ..pageNumber))
    } else {
      let errorMessage = "Label '" + labelText + "' is not defined"
      panic(errorMessage)
    }
  })
}

#let author_counter = counter("author_counter")
#let contacts_counter = counter("contacts_counter")

#let print_author(author) = {
  text(weight: "bold")[#author.name]
  link("https://orcid.org/" + author.orcid)[#icon("resources/orcid_icon.png", )]
  super(author.affiliation)
  author_counter.step()
  super(author_counter.display())
}

#let print_affiliation(affil) = [
  #affil.id: #affil.value
]

#let print_contact(author) = [
  #author.shortname,
  Email: #if author.corresponding [(Corresponding Author)]
  #link("mailto:" + author.email)
]

#let project(title: "", abstract: [], authors: (), affiliations: (), work_in_progress: false, body) = {
  // TODO: Fix this?
  set document(author: authors.map(a => a.name), title: title)
  // Set the document's basic properties.
  set page(
    numbering: "1",
    number-align: end,
    margin: (
      left: 3cm,
      right: 3cm
    )
  )
  
  set text(
    font: "Atkinson Hyperlegible",
    size: 11pt,
    lang: "en",
    tracking: 0.1pt,
    slashed-zero: true,
  )

  init-acronyms(my_acronyms)

  // Colored links
  show link: words => {
    text(fill: blue)[#underline(words)]
  }

  // Set paragraph spacing.
  show par: set block(above: 1em, below: 1.5em)

  set heading(numbering: "1.1")
  set par(leading: 0.75em)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.6em, title))
  ]

  // Author information.
  block(inset:0.3em, {
    authors.fold("", (rest, author) => [
      #rest #if rest != "" [,] // a bit of a hack
      #print_author(author)
      ]
    )
    parbreak()
    // Affiliation and email block
    pad(top: -0.5em, bottom: 0.3em, x: 1.5em)[
      #set text(size: 0.8em, fill: rgb("#3c3d59"))
      #affiliations.fold("", (rest, affiliation) => align(left)[
        #rest 
        #print_affiliation(affiliation)
      ])
      #authors.fold("", (rest, author) => [
      #rest #if rest != "" [,] // a bit of a hack
        #contacts_counter.step()
        #contacts_counter.display():
        #print_contact(author)
      ]
    )
  ]

  }) // End of authors block


  // Main body.
  set par(justify: true)
  
  pad(x:9%)[
    #heading(outlined: false, numbering: none, text(1em, smallcaps[Abstract]))
    
    #text(size: 0.9em)[#abstract]
  ]

  // Figure customizations
  show figure.caption: set text(size: 0.9em, fill: rgb("#3d424a"))

  show heading.where(
    level: 3
  ): it => text(
    weight: "regular",
    style: "italic",
    fill: rgb("#38393b"),
    it.body + [.],
  )

  if work_in_progress {
    set align(center)
    block(
      breakable: true,
      fill: rgb("#ff8269"),
      inset: 8pt,
      radius: 4pt
    )[
      #align(center)[
        #v(0.5cm)
        
        #text(size:20pt, weight: "bold")[This is a draft]
        
        Regenerated from source code on #datetime.today().display("[year].[month].[day]")
        
        #h(15cm)
      ]
    ]
    
  } else {
    
  }

  body
}

#let acrlong(shortcode) = {
  reset-acronym(shortcode)
  acr(shortcode)
}

#let acrpllong(shortcode) = {
  reset-acronym(shortcode)
  acrpl(shortcode)
}