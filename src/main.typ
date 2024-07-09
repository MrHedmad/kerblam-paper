#import "template.typ": *
#show: project.with(
  title: "Structuring data analysis projects in the Open Science era with Kerblam!",
  authors: (
    (
      name: "Luca Visentin",
      shortname: "L.V.",
      email: "luca.visentin@unito.it",
      affiliation: "*",
      orcid: "0000-0003-2568-5694",
      corresponding: true
    ),
    (
      name: "Luca Munaron",
      shortname: "L.M.",
      email: "luca.munaron@unito.it",
      affiliation: "*",
      orcid: "0000-0001-9247-4446",
      corresponding: false
    ),
    (
      name: "Federico Alessandro Ruffinatti",
      shortname: "F.A.R.",
      email: "federicoalessandro.ruffinatti@unito.it",
      affiliation: "*",
      orcid: "0000-0002-3084-0380",
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
*/

= Introduction

Data analysis is a key step in every scientific experiment.
In numerical-data-centric fields, input data is processed by one or more programs to produce output data for human inspection, potentially saving intermediate data on the way.
However, how such data analysis projects are structured can be significantly different among different researchers, making it harder for the public to inspect and understand them.

With "Data analysis project structure" we refer to the way in which data analysis projects are organized, including the structure of the folders present on disk, the places where code and workflows are stored in, and how the project is shared with the public.
With the Open Science movement gaining more and more traction in the recent years @bertramOpenScience2023, there is a need to standardize how day-to-day data analysis projects are structured and carried out.
Additionally, there is a need to make reproducible pipelines easier to create and to execute by the wider public, for example by leveraging methods such as containerization.

New tools and technologies offer new opportunities to render the data analysis process increasingly transparent and reproducible. At the same time, usage of these tools takes time and effort, as well as expertise and sensibility to the issue of standardization and reproducibility.

In this paper, we inspect the structure of data analysis projects that are currently used, and propose a simple yet flexible template project that can be adapted to many contexts while providing a certain level of standardization.
We also present a tool that can be used to work with such a project, leveraging its structure to provide a number of useful features. We named this tool Kerblam!.

== FAIR Projects

The FAIR principles were published in 2016 @wilkinsonFAIRGuidingPrinciples2016, and they provide a guideline for making data Findable, Accessible, Interoperable, and Reusable for the benefit of all.
These principles were adapted in other contexts, such as software @barkerIntroducingFAIRPrinciples2022.

We believe that it is possible to follow FAIR principles when structuring data analysis projects, making them more transparent and reusable by other researchers and the public.
This could ultimately benefit the scientific community by making other's work easier to understand and reproduce, for example during the peer review process.

The structure of this paper is as follows.
First, we present the structure of many data science / data analysis project templates available online.
Then, we outline best practices and cosiderations to take into account when thinking about structuring data analysis projects.
Following these principles, we propose a simple, lightweight and extensible project structure that fits many needs and is in line with the projects already present in the ecosystem.
Finally, we present Kerblam!, a tool to help work in projects with this standard structure, taking care of common tasks like data retrieval and cleanup, as well as workflow management.

= Materials and Methods

In order to fetch the structure of common data analysis projects, we searched GitHub for the keywords 'cookiecutter' and 'data'.
The Python `cookiecutter` package allows users to create ("cut") new projects based on project templates.
We downloaded the top 50 such repositories sorted by GitHub stars and cut them with the `cookiecutte` python package into projects.
Of these fifty repositories, 31 could ultimately be successfully cut and were therefore considered.
We then listed all files and folders in the resulting projects, and compiled them into a frequency graph.
The code for this analysis is available at #link("https://github.com/MrHedmad/ds_project_structure")[MrHedmad/ds_project_structure].

Kerblam! is a command line tool written in Rust available on Github at #link("https://github.com/MrHedmad/kerblam")[MrHedmad/kerblam], online at #link("https://kerblam.dev/")[kerblam.dev] and on Zenodo at #link("https://doi.org/10.5281/zenodo.10664806")[10.5281/zenodo.10664806].

= Results
The issue of structuring projects is one universally shared by anyone performing data analysis.
This results in a plethora of different tools, folder hirerachies,

#lorem(100)

///* Include Appendices
#pagebreak(weak: true)
#set heading(numbering: "A.1", supplement: "Appendix")
#counter(heading).update(0)
= Appendix
#lorem(50)
== Appendix
#lorem(50)

//*/

#pagebreak()
#bibliography("resources/refs.bib", style: "resources/nature-no-superscript-square.csl")
