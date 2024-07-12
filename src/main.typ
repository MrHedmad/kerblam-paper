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
In numerical-data-centric fields, input data is processed by one or more programs to produce output data, often for human inspection, potentially saving intermediate data on the way.
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

In order to fetch the structure of common data analysis projects, we searched GitHub for the keywords 'cookiecutter' and 'data', as well for the much more generic keywords 'project' and 'template'.
The Python `cookiecutter` package allows users to create ("cut") new projects based on project templates.

We downloaded the top 50 such repositories from each search sorted by GitHub stars.
For each downloaded project, we either cut them with the `cookiecutter` python package or used them as-is (for non-cookiecutter templates).
Of these $100$ repositories, $87$ could ultimately be successfully cut and parser, and were therefore considered.
We then listed all files and folders in the resulting projects, and compiled them into a frequency graph.
The code for this analysis is available at #link("https://github.com/MrHedmad/ds_project_structure")[MrHedmad/ds_project_structure].

Some housekeeping files were stripped from the final search results due to not being relevant to the project as a whole.
For example, `.gitkeep` files, which are commonly used to commit empty directories to version control, were excluded from the final figures. Finally, files present in less that two templates were discarded.

The analysis was performed with the latest commits of all the considered repositories as of the 12th of July, 2024.

Kerblam! is a command line tool written in Rust available on Github at #link("https://github.com/MrHedmad/kerblam")[MrHedmad/kerblam], online at #link("https://kerblam.dev/")[kerblam.dev] and on Zenodo at #link("https://doi.org/10.5281/zenodo.10664806")[10.5281/zenodo.10664806].

#pagebreak(weak: true)
= Results
== Landscape of project templates
The issue of structuring projects is one universally shared by anyone performing data analysis.
This results in a plethora of different tools, folder hirerachies, accepted practices and customs.

#figure(
  image("resources/images/plot.png"),
  caption: [#todo[Write a description of some sort]],
  placement: top
) <fig:frequency_graph>

We inspected $87$ different project template structures, and produced a frequency graph visible in @fig:frequency_graph.
By looking at this figure, we can point out common patterns in folder structure.
It must be highlighted, however, that templates influence each other.
For example, many python data science project templates seem to be modified
versions of #link("drivendataorg/cookiecutter-data-science")[https://github.com/drivendataorg/cookiecutter-data-science],
which has a very high number of stars and is therefore probably popular with the community.

In any case, the two most highly found files are the `README.md` file ($77 / 87 tilde.eq 0.88$) and the `LICENSE` and the `LICENSE.md` ($(46 + 3)/ 87 tilde.eq 0.56$) files, unsurprisingly:
the `README.md` file is almost universally found in most projects, describing the project itself,
while the `LICENSE` file is essential for collaborating with the community in the open source paradigm.

The `pyproject.toml` file at the top level of the repository, marking the project as a Python package, is also prevalent ($16 / 87 tilde.eq 0.18$).
This is potentially due to the popular "cookiecutter-data-science" template already mentioned previously.
This means that projects following the template are intimately linked with the usage of Python, potentially exclusively.
The predominance of python-based projects is also noticeable by the presence of the `requirements.txt` (usually used to store Python's package dependencies), `setup.py` and `setup.cfg` (now obsolete versions of the `pyproject.toml` file to configure Python's build system) files.
The `project` folder at the top level of the templates is most likely the Python package (represented by the `__init__.py` file) that the `pyproject.toml` file refers to:
the name "project" is artificial, deriving from the default way that cookiecutter templates were cut.

The presence of files related to the R programming language (the `R` directory, `.Rbuildignore`, `README.Rmd`) reflect its usage in the data analysis field, although at a lower frequency that what we expected.
This is potentially due to biases introduced by the search queries, or to the overwhelming popularity of Python project templates.

Community-relevant files such as the `CONTRIBUTING.md` ($8/87 tilde.eq 0.09$) and `CODE_OF_CONDUCT.md` ($ 5/87 tilde.eq 0.05$) show little prevalence in templates.
This is also true for the `CITATION.cff` ($4/87 tilde.eq 0.04$) file, useful for machine-readable citation data.

The `src` ($31/87 tilde.eq 0.35$), `data` ($35/87 tilde.eq 0.40$) and `docs` ($28/87 tilde.eq 0.32$) folders are very highly represented, containing respectively code; input, output and intermediate data; and project documentation.
The `data` directory contains with high frequency the `raw`, `processed`, `interim` and `external` folders for the different data types.
This is the structure that "cookiecutter-data-science" promotes, henche its high representation.
Interestingly, other templates include `data` in the `src` folder, mixing it with analysis code.
Other common folders present in the `src` directory are also the ones promoted by the "cookiecutter-data-science" template. The prevalence of these sub-folders is however lower that the frequency of `src` itself, signifying that the `src` folder is not uniquely due to that specific template.

Docker-related files are present, mostly in the top-level of the project: `Dockerfile` ($ 5/87 tilde.eq 0.05$), `.dockerignore` ($4/87 tilde.eq 0.04$) and `docker-compose.yml` or `yaml` ($(6 + 1)/87 tilde.eq 0.08$).
Docker related files and folders are also present with sub-threshold frequency in many other forms, often as directories with multiple Dockerfiles in different folders (see @ax:freq_table).
The presence of the `docker-compose.yml` file and the docker sub-directories might reflect the need to manage multiple execution environments (that work together in the case of Docker compose) troughout the analysis.

The sparse usage of many tools can be appreciated by the amount of unique files and folders across all templates.
Out of $4195$ different files and directories considered by this approach, the overwhelming majority, $3908$, or $93.15%$ is present only in one template. Looking at only directories, $783$ are unique over $864$ total, or $90.62%$.
This figure might be inflated due to the presence of some compiled libraries, files and Git objects that are included in the analysis.
In any case, this low consensus between different project templates reflects the high fragmentation of tooling, methodology and conventions used in the ecosystem.

// Are we coming in too strong?

/*
== Relevant project templates
Several consortia higlight best practices when dealing with project structure.
We highlighted a few in this section, together with relevant templates.

=== The Turing Way
The Turing Way @communityTuringWayHandbook2022 is a widely popular resource to address many aspects of project and data management.
The handbook contains a section with a linked 
*/

#pagebreak(weak: true)
#set heading(numbering: "A.1", supplement: "Appendix")
#counter(heading).update(0)
= Full path frequency table
<ax:freq_table>
#todo[Include here the full table (as a link maybe) to the `result.csv` file of the analysis.]


#pagebreak()
#bibliography("resources/refs.bib", style: "resources/nature-no-superscript-square.csl")
