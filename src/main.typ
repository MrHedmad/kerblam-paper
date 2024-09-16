#import "template.typ": *;
#import "@preview/subpar:0.1.1";

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
    (id: "*", value: "Department of Life Sciences and Systems Biology, University of Turin, Turin, Italy"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract: [
    Structuring data analysis projects, that is, defining the layout of files and folders needed to analyse data using existing tools and novel code, largely follows personal preferences. In this work, we look at the structure of several data analysis project templates and find little structural overlap. We highlight the parts that are similar between them, and propose guiding principles to keep in mind when one wishes to create a new data analysis project. Finally, we present Kerblam!, a project management tool that can expedite project data management, execution of workflow managers, and sharing of the resulting workflows and analysis outputs. We hope that, by following these principles and using Kerblam!, the landscape of data analysis projects can become more transparent, understandable, and ultimately useful to the wider community.
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
In numerical-data-centric fields, data analysis is, in essence, a series of computational steps in which input data is processed by software to produce some output.
Usually, the ultimate goal of such analyses is to create secondary data for human interpretation in order to produce knowledge and insight on the raw input data.
These manipulations can involve downloading input data on local storage, creating workflows and novel software---also saved locally---and running the analysis on local or remote ("cloud") hardware.

In this article, we will use the phrase “data analysis project structure” to refer to the way data analysis projects are organized on the actual file system, including the structure of the folders on disk, the places where data, code, and workflows are stored, and the format in which the project is shared with the public.
Unfortunately, such structures can vary a lot from one researcher to another, making it hard for the public to inspect and understand them.

With the Open Science movement gaining more and more traction in the recent years @bertramOpenScience2023, there is a growing need to standardize how routine data analysis projects are structured and carried out.
Indeed, by making data analyses more transparent and intelligible, the standardization of project structure complies with the FAIR principles' call for more Findable, Accessible, Interoperable, and Reusable data @wilkinsonFAIRGuidingPrinciples2016.

Notably, even if originally thought to provide guidelines for the management of data, FAIR principles have recently been extended also to other contexts, such as that of software @barkerIntroducingFAIRPrinciples2022.
Consistently, efforts are being made from many parts to make reproducible pipelines easier to be created and executed by the wider public---for example by leveraging methods such as containerization.
However, while new tools and technologies offer unprecedented opportunities to make the whole process of data analysis increasingly transparent and reproducible, their usage still takes time and effort, as well as expertise and sensibility to the issue of standardization and reproducibility by the experimenter.

In this work, we inspect the structure of many data science / data analysis project templates currently available online.
Then, we outline best practices and considerations to take into account when thinking about structuring data analysis projects.
Following these principles, we propose a simple, lightweight and extensible project structure that fits many needs and is in line with the projects already present in the ecosystem, thus providing a certain level of standardization.
Finally, we present Kerblam!, a new tool that can be used to work in projects with this standard structure, taking care of common tasks like data retrieval and cleanup, as well as workflow management and containerization support.
This could ultimately benefit the scientific community by making others' work easier to understand and reproduce, for example during the peer review process.

= Materials and Methods
== Structure of common project templates
To fetch the structure of common data analysis projects, we searched GitHub for the keywords _cookiecutter_ and _data_, as well as the much more generic keywords _project_ and _template_.
The Python `cookiecutter` package allows users to create ("cut") new projects based on project templates.

// I know everything is in 'Code and Data availability' section, but shouldn't we mention here too the 'ds_project_structure' repo as the method we "searched GitHub"...?

We downloaded the top 50 such repositories from each search sorted by GitHub stars, as a proxy for popularity and adoption rate.
For each downloaded project, we either cut it with the `cookiecutter` Python package or used it as-is (for non-cookiecutter templates).
Of these $100$ repositories, $87$ could ultimately be successfully cut and parsed, and were therefore considered.
All files and folders from the resulting projects were finally listed and then compiled into a frequency graph.

// Why they are 100 in total? How many searches we performed? Two? But the keywords are four...

Some housekeeping files (like the `.git` directory and all its content) were stripped from the final search results as they were deemed not relevant to the project as a whole.
For example, `.gitkeep` files---which are commonly used to commit empty directories to version control---were excluded from the final figure. Finally, files present in strictly less than three templates were also discarded.

The analysis was performed with the latest commits of all the considered repositories as of the 12th of July, 2024.
The only exception was the "drivendataorg/cookiecutter-data-science" repository, for which we fetched version `1.0` due to non-standard parsing requirements of the latest commit.

== Kerblam!
Kerblam! is a command line tool available on GitHub at #link("https://github.com/MrHedmad/kerblam")[MrHedmad/kerblam], online at #link("https://kerblam.dev/")[kerblam.dev], and on Zenodo for long-term availability at #link("https://doi.org/10.5281/zenodo.10664806")[10.5281/zenodo.10664806].

Kerblam! is written in Rust and may be compiled to support both GNU/Linux-flavoured operating systems and Mac-OS.
Alternatively, GitHub releases provide pre-compiled artifacts for both these operating systems.
Support for Windows machines is untested at the time of writing.

#pagebreak(weak: true)

= Results
== The landscape of data analysis project templates

// I don't know if it is accepted in typography the practice of inserting a single subsection...

The choice of how to structure projects is an issue universally shared by anyone who performs data analysis.
This results in a plethora of different tools, folder hierarchies, accepted practices, and customs.
To explore the most common project-structuring practices, we inspected $87$ different project templates available on GitHub and produced a frequency graph of shared files and folders visible in @fig:frequency_graph.

#figure(
  image("resources/images/plot.png"),
  caption: [Frequency graph of the structure of the 87 most starred data analysis project templates, as retrieved from GitHub. Files present in less than three templates were ignored. The size and color intensity of the circle at the tip of each link is proportional to the frequency with which this file or folder is found in different project templates. Red text represents files, while blue text represents folders. The central dot of the root node was assigned an arbitrary size.],
  placement: top
) <fig:frequency_graph>

// 'less than two' or 'less than three' ??

By looking at this figure, we can point out common patterns in project structure.
It must be highlighted, however, that templates influence each other.
For example, many Python data science project templates seem to be modified versions of #link("https://github.com/drivendataorg/cookiecutter-data-science")[drivendataorg/cookiecutter-data-science], which has a very high number of stars and is therefore probably popular with the community.

In any case, the two most highly found files are the `README.md` file (with a frequency of $77 / 87 tilde.eq 0.88$) and the `LICENSE` and `LICENSE.md` files ($(46 + 3)/ 87 tilde.eq 0.56$).

The `pyproject.toml` file at the top level of the repository---marking the project as a Python package---is also prevalent ($16 / 87 tilde.eq 0.18$).
This is potentially due to the popular "cookiecutter-data-science" template mentioned before, also highlighting how projects following this template are intimately linked with the usage of Python, potentially exclusively.
The predominance of Python-based projects is also noticeable by the presence of `requirements.txt` (a file usually used to store Python's package dependencies), `setup.py`, and `setup.cfg` (now obsolete versions of the `pyproject.toml` file, used to configure Python's build system).
The `project` folder at the top level of the templates is most likely the Python package (represented by the `__init__.py` file) that the `pyproject.toml` file refers to (the name "project" is artificial, deriving from the default way that cookiecutter templates were cut).

The presence of files related to the R programming language (the `R` directory, `.Rbuildignore`, `README.Rmd`) reflect its usage in the data analysis field, although at a lower frequency than that of Python.

Community-relevant files such as the `CONTRIBUTING.md` ($8/87 tilde.eq 0.09$) and `CODE_OF_CONDUCT.md` ($ 5/87 tilde.eq 0.05$) show little prevalence in templates.
This is also true for the `CITATION.cff` ($4/87 tilde.eq 0.04$) file, useful for machine-readable citation data.

The `src` ($31/87 tilde.eq 0.35$), `data` ($35/87 tilde.eq 0.40$), and `docs` ($28/87 tilde.eq 0.32$) folders are very highly represented, containing code, data, and project documentation, respectively.
In particular, the `data` directory contains with a high frequency the `raw`, `processed`, `interim`, and `external` folders to host the different data types---input, output, intermediate, and third party---according to the structure promoted by the "cookiecutter-data-science" template.
The prevalence of these sub-folders, however, is lower than the frequency of `data` itself, which means that the presence of `data` folder is not uniquely due to that specific template.
Interestingly, other templates include `data` in the `src` folder, mixing it with analysis code.
Other common folders present in the `src` directory are also the ones promoted by "cookiecutter-data-science", but again, as already noted for `data`, their occurrence is lower than that of the parent folder, indicating that many different templates adopt `src` as a folder name.

Docker-related files are present, mostly in the top-level of the project: `Dockerfile` ($ 5/87 tilde.eq 0.05$), `.dockerignore` ($4/87 tilde.eq 0.04$), and `docker-compose.yml` or `yaml` ($(6 + 1)/87 tilde.eq 0.08$).
Docker-related files and folders are also present with sub-threshold frequencies in many other forms, often as directories with multiple Dockerfiles in different folders.
The presence of the `docker-compose.yml` file and the docker sub-directories might reflect the need to manage multiple execution environments (that work together in the case of Docker Compose) throughout the analysis.

The sparse usage of many tools can be appreciated by the amount of unique files and folders across all templates.
Out of $4195$ different files and directories considered by this approach, the vast majority ($3908$, or $93.15%$) are present in only one template.
Looking at directories only, $783$ are unique over $864$ total ($90.62%$).
This figure might be inflated due to the presence of some compiled libraries, files, and Git objects that are included in the analysis and not correctly removed by our filtering.
However, we argue that this overwhelmingly high uniqueness would not be significantly affected by manual filtering.

// Are we coming in too strong?
// never enough...

/*
== Relevant project templates
Several consortia higlight best practices when dealing with project structure.
We highlighted a few in this section, together with relevant templates.

=== The Turing Way
The Turing Way @communityTuringWayHandbook2022 is a widely popular resource to address many aspects of project and data management.
The handbook contains a section with a linked
*/

= Discussion
Project structure can be, by its nature, a matter of personal preference.
The most interesting result from our analysis is indeed the tiny overlap between templates.
At the same time, @fig:frequency_graph confirms that the core structure of the repositories tends to be similar.
This is potentially due to both the epistemic need to share one's own work with others and technical requirements of research tools, which cause the adoption of community standards either by choice (in the former case) or imposition (in the latter).
For instance, the high presence of the `README.md` file is a community standard that is broadly shared by the majority of software developers, users, and researchers alike.
This adoption is purely due to practical reasons: specifically the need to share the description of the work with others in an obvious ("please read me"), logical (in the topmost layer of the project layout), and predictable (i.e., used by the wider community) way.

Borrowing a term from genetics, the `README` file can be thought to be a "housekeeping" file: without it, the usefulness of a project is severely impaired.
In this regard, another possible housekeeping candidate is the `LICENSE` file.
It is essential for collaborating with the community in the Open Source paradigm, and thus commonly found in many software packages.
The concession for code reuse is also essential in data analysis projects, both to allow reproducers to replay the initial work and for other researchers to build on top of previous knowledge.
Incidentally, the common presence of the `LICENSE` file in the _template_ of a project is interesting.
This could be either due to apathy toward licensing issues, leading to picking a "default license" without particular considerations, or a general feeling in individuals that one particular license fits their projects across the board.

A potentially new housekeeping file that is however not yet commonly found is the `CITATION.cff` file.
This file contains machine-readable citation metadata, which could be used by both human and machine users to obtain such information, potentially automatically.

The relatively low prevalence of the R programming language could be due to biases introduced by the search queries, or to the overwhelming popularity of Python project templates, also in the light of the fact that the cookiecutter utility itself is written in Python.

== Designing a data analysis project template
The observations made above can all be taken into consideration when designing a more broadly applicable project template that may be used in a variety of contexts.
To this end, it is helpful to conceptualize some core guiding principles that should be followed by all data analysis projects, in particular under the Open Science paradigm.

As data analysis projects often involve writing new software, a data analysis project structure requires support for both *data analysis* proper and *software development*.

The methods of software development fall outside the scope of this work, but some concepts are useful in the context of data analysis, particularly for _ad hoc_ data analysis.
For instance, many programming languages require specific folder layouts in order to create self-contained, distributed software.
Take, for instance, the Python programming language: to create a Python package, a specific project layout has to be followed @PackagingPythonProjects.
This is visible also in @fig:frequency_graph, with the presence of the "project" folder, and many files specific to Python packages, crucially, in the locations required by Python build backends.
Something similar occurs for many programming languages, such as R @PackageStructureState and Rust @CreatingNewPackage, among others.

However, a researcher might not want to create self-contained, distributed software.
Languages like Python and R can interpret and execute single-file scripts which achieve some goal (i.e., "scripting").
As scripting is so fast, convenient, and easy to do, it is the most common method of doing data analysis.
Scripting provides much flexibility during the development process, but this typically exacerbates the fragmentation of project structures.
In particular, the environment of execution now becomes much more relevant: which packages are installed and at which versions, the order that the scripts were read and executed, sometimes, even the order of _which lines_ in the scripts are (manually) run become important to the success of the overall analysis.

This increased flexibility is obviously useful for the research process, which requires the ability to change quickly in order to adapt to new findings, especially during exploratory research.
The principles presented here aim to retain this essential feature, but, at the same time, push for increased standardization of methods, avoiding the most common and dangerous pitfalls one can encounter during the process of data analysis.

=== 1. Use a version control system
At its core, software is a collection of text files, and this includes data analysis software.
While working on code, it is important to record the differences between the different versions of these files.
This is very useful, especially during the research process, to "retrace our steps" or to attempt new methodologies without the fear of losing any previous work.
Such records are also useful as provenance information, and potentially as proof of authorship, similarly to what a laboratory notebook does for a "wet-lab" experimental researcher.

There is consolidated software that can be used as a version control system.
The overwhelming majority of projects use `git` to this aim, although others exist.
Platforms that integrate `git` such as GitHub (#link("https://github.com")[github.com]) and GitLab (#link("https://gitlab.com")[gitlab.com]) are increasingly used for data analysis both as a collaboration tool during the project and a sharing platform afterwards.

The first principle is therefore this: use a version control system, such as `git`.

A few practical observations stem from this principle:
- version control encourages good practices, such as atomic commits, meaningful commit messages, and more;
- version control discourages the upload of very large (binary) files, so input and output data cannot be efficiently shared through such a system;
- code collaboration and collaboration techniques (such as "Github Flow" or "trunk based development" @appletonStreamedLinesBranching1998 @GitHubFlow) can be useful to promote a more efficient workflow method in data analysis disciplines such as bioinformatics;
- the core unit of a project should be a code repository, containing everything related to that project.

The usage of a version control system has implications also for FAIR-ness.
Leveraging remote platforms can be fundamental for both Findability and Accessibility.
Integrations of platforms like GitHub with archives like Zenodo, for instance, allow developers to easily archive for long-term preservation their data analysis code, promoting Accessibility, Findability, and Reusability.

=== 2. Documentation is essential
When working on a data analysis project, documentation is important for both the experimenter themselves and any possible external users.
Through ideal documentation, the rationale, the process, and potentially the result of the analysis are presented to the user, together with practical steps on how to *actually* reproduce the work.
As with all other aspects of data analysis, documentation takes many different forms, but is the most difficult thing to standardize for one simple reason: documentation is written by humans for human consumption.
Documentation is therefore allowed high flexibility in structure, content, form, and delivery method.

Even with such a lax structure, some guidelines on how to write effective documentation can still be drawn, oftentimes from best practices in the much wider world of Open Source software.

We have already highlighted the fundamental role of the `README` file and its very wide adoption.
The `README` file contains high-level information about the project.
This file is usually the first, and perhaps only, documentation that all users encounter and read.
It is therefore essential that core aspects of the project are delivered trough the `README` file, such as:
- the aim of the project, in clear, accessible language;
- the methods used to achieve such aim (and/or a link to further reading material);
- a guide on how to run the analysis on the user's machine, potentially including information on hardware requirements, software requirements, container deployment methods, and every information a human reproducer might need to execute the analysis;
- in a Open Science mindset, including information on how to collaborate on the project and contact information of the authors is also desirable.
Other aspects of the project, such as a list of contributors, might also be included in the `README` file.
The `README` file may also be named `DESCRIPTION`, although `README` is a much more widely accepted standard.

Additional documentation can be added to the project in many forms (also see @fig:frequency_graph).
A common documentation file is the `CONTRIBUTING` file, with information on how to contribute to the project, on how authorship of eventual publications will be assigned, and other community-level information.
The `CODE_OF_CONDUCT` file contains guidelines and policy on how the project is managed, the expected conduct of project members, and potentially how arising issues between project members are dealt with.
Such a file can be important to either projects open to collaboration from the public or large consortium-level projects.

Another important documentation file in the Open Source community is the `CHANGELOG` file.
It contains information about how the project changed over time and its salient milestones.
For data analysis, it could be used to inform collaborators of important changes in the codebase, methodology or any other news that might be important to announce and record.
Additionally, together with the commit history, `CHANGELOG` files can be useful to track the provenance of the analysis, as we have already mentioned.

A common place to store documentation is the top-level of the project repository, but some templates use the `docs` folder, also coming from guidelines used in the Python community (to use tools such as Sphinx @SphinxSphinxDocumentation).

We can conclude by reiterating that the second principle states that documentation is essential.

=== 3. Be logical, obvious and predictable
When a project layout is logical, obvious, and predictable, a human user can easily and quickly understand and interact with it.

To be *logical*, a layout should categorize files based on their content, and logically arrange them following such categories.
To be *obvious*, this categorization should make sense at a glance, even to non-experts.
For instance, a folder named "scripts" should contain scripts (to be obvious) and only scripts (to be logical).
To be *predictable*, a layout should adhere to community standards, so that it "looks" similar to other projects.
This creates minimal friction when a user first encounters the project and desires to interact with it.

This principle is present also in other aspects of project structure other than layout.
For instance, the structure of documentation can also benefit from the same principles, but in a different context: logically arranged, obvious in structure, and similar to other projects.

We can summarise this third principle like this: be logical, obvious and predictable.

=== 4. Promote (easy) reproducibility
Scientific Reproducibility has been and still is a central issue, particularly in the field of biomedical research @erringtonChallengesAssessingReplicability2021 @ioannidisWhyMostPublished2005a.
Scientific software developers hold the crucial responsibility towards the scientific community of creating reproducible data analysis software.

"Reproducibility" can be understood as the ability of a third-party user to understand the research issue investigated by the project, how it was addressed, and practically execute the analysis proper again to obtain a hopefully similar and ideally identical result as the original author(s).
This has twofold benefits: a reproducible analysis evokes more confidence in those that read and review it, and it makes it much easier to repurpose the analysis to similar data in the future.

In the modern era, scientists are equipped with powerful tools to enable reproducibility, such as containerization, virtualization, etc.
While a discussion on how reproducibility can be achieved eludes the scope of this article, the project layout can promote it, especially when all other principles exposed here are respected.
This increased adoption can be promoted by including obvious and easily implementable reproducibility methods right in the layout of the project.

Workflow managers, like Nextflow @ditommasoNextflowEnablesReproducible2017, Snakemake @molderSustainableDataAnalysis2021, and the Common Workflow Language @crusoeMethodsIncludedStandardizing2022 are key tools to enable reproducibility.
They allow a researcher to describe in detail the workflow used, from input files to final output, offloading the burden of execution to the workflow manager.
This allows greater transparency in the methodology used, and even makes reproducibility a possibility in more complex data analysis scenarios.
Additionally, some workflow managers are structured to promote reusability of the analysis code, even on different architectures or in high performance computing environments @crusoeMethodsIncludedStandardizing2022.

We can conclude this section by stating the fourth and last principle: be (easily) reproducible.

== Kerblam!
We have designed a very simple but powerful and flexible project layout together with a project management tool aiming at upholding the principles outlined in the previous section.
We named this tool "Kerblam!".

#subpar.super(
  {
  grid(
    [#figure(image("resources/images/layout.svg"), caption: []) <fig:kerblam:layout>],
    [#figure(image("resources/images/cow.svg"), caption: []) <fig:kerblam:datatypes>],
    columns: (1fr, 1fr)
  )
    [#figure(image("resources/images/flow.svg"), caption: []) <fig:kerblam:flow>]
  v(3mm)
  },
  caption: [Salient concepts implemented by Kerblam!
    (a): Basic skeleton of the proposed folder layout for a generic data analysis project associated with relevant Kerblam! commands.
    Folders are depicted in blue, while files are depicted in red.
    (b): Data is qualitatively divided into input, output and temporary data. Input data can be further divided in input data remotely available (i.e., downloadable) and local-only data. The latter is "precious", as it cannot be easily recreated. Other types of data are "fragile", as they may be created again _on the fly_.
    (c): Overview of a generic Kerblam! workflow.
  ],
  label: <fig:kerblam>
)

Kerblam! is a command-line tool written in Rust that incentivizes researchers to use a common, standardized filesystem structure, adopt containerization technologies to perform data analysis, leverage remote file storage when possible, package and make container images publicly available to re-run pipelines for reproducibility purposes (see @fig:kerblam:flow).
These aims try to allow and promote the principles described above.

The most basic skeleton of the project layout implemented by Kerblam! can be seen in @fig:kerblam:layout.
The `kerblam.toml` file contains configuration information for Kerblam! and marks the folder as a Kerblam-managed project.
Kerblam! provides a number of utility features _out of the box_ on projects that adapt to the layout presented in @fig:kerblam:layout or on any project provided proper configuration.

=== Data management
Kerblam! can be used to manage a project's data.
Kerblam! automatically distinguishes between input, output, and intermediate data, based on which folder the data files are saved in:
the `data` folder contains intermediate data produced during the execution of the workflows; the `data/in` contains input data, and similarly `data/out` contains output data.
Furthermore, the user can define in the `kerblam.toml` configuration which input data files can be fetched remotely, and from which endpoint.
This allows Kerblam! to both fetch these files upon request (`kerblam fetch`) and to distinguish between remotely available input files and local-only files.
Local-only files are deemed "precious", as they cannot be easily recreated.
All other data files are "fragile", as they can be deleted without repercussion to save disk space (@fig:kerblam:datatypes).

// Sure "fragile" is a good term?

These distinctions between data types enable further functions of Kerblam!.
`kerblam data` shows the number and size of files of all types, to quickly check how much disk space is being used by the project.
Fragile data can be deleted to save disk space with `kerblam data clean` and precious input data can be exported easily with `kerblam data pack`. `kerblam data pack` can also be used to export output data quickly to be shared with, for example, colleagues.

Allowing Kerblam! to manage the project's data with these tools can offload several chores usually done manually by the experimenter.

=== Workflow management
Kerblam! can manage multiple workflows written for any workflow manager.
At its core, Kerblam! can spawn shell subprocesses that then execute the particular workflow manager, potentially one configured by the user.
This allows Kerblam! to manage _other_ workflow managers, making them transparent to the user.

Kerblam! also can act before and after the workflow manager proper to aid in several tasks.
Firstly, Kerblam! can manage workflows in the `src/workflows` folder *as if* they were written in the root of the project.
It achieves this by moving the workflow files from said folder to the root of the repository _just before_ execution.
This allows for slimmer workflows which do not crowd the root of the repository or conflict with each other, thus being more consistent.

Secondly, it allows the concept of _input data profiles_.
Data profiles are best explained through an example.
Imagine an input file, `input.csv`, containing some data to be analysed.
The experimenter may wish to test the workflows that they have written with a similar, but---say---smaller `test_input.csv`.
Kerblam! allows the hot-swapping of these files just before execution of the workflow manager trough profiles.
By configuring them in the `kerblam.toml` file, the experimenter can execute a workflow manager (with `kerblam run`), specifying a profile:
Kerblam! will then swap these two files just before and just after the execution of the workflow to seamlessly use exactly the same workflow but with different input data, in this case for testing purposes.

Kerblam! supports _out of the box_ GNU `make` as its workflow manager of choice.
Indeed, makefiles can directly be ran trough Kerblam! with no further configuration by the user.
Any other workflow manager can be used by writing tiny shell wrappers with the proper invocation command.
The range of workflow managers supported out-of-the-box by Kerblam! may increase in the future.

=== Containerization support
Containers can be managed directly by Kerblam!.
By writing container recipes in `src/dockerfiles`, Kerblam! can automatically execute workflow managers inside the containers, seamlessly mounting data paths and performing other housekeeping tasks before running the container.
This allows for very easy containerization of workflow managers that do not support it themselves, or even containerization of shell scripts, be they used for writing the workflow proper.

// Not sure about the meaning... Rephrase.

With these capabilities, Kerblam! promotes reproducibility and allows even inexperienced users to perform even the simplest analyses in a reproducible way.

=== Pipeline export
Workflows managed by Kerblam! with an available container can be automatically exported in a reproducible package through `kerblam package`.
This creates a preconfigured container image ready to be uploaded to a container registry of choice together with a compressed tarball containing information on how to (automatically) replay the input analysis: the "replay package".

The process automatically strips all unneeded project files, leading to small container images.

The replay package can be inspected manually by a potential examiner, and either re-run manually or trough the convenience function `kerblam replay` which recreates the same original project layout, fetches the input container and runs the packaged workflow.

=== The Kerblam! analysis flow
Kerblam! favours a very specific methodology when analysing data, starting with an empty `git` repository.
First, upload the input data in some remote archive (in theory promoting FAIR-er data).
Then, configure Kerblam! to download the input data, and write code and workflows to analyse it, potentially in isolated containers or with specific workflow management tools.
During development, periodically clean out intermediate and output files to check if the correct execution of the analysis has become dependent on local-only state.
Finally, package the results and pipelines into the respective environments and share them with the wider public (e.g., as a GitHub release or in an archive like Zenodo).

We believe that this methodology is simple yet flexible and robust, allowing for high-quality analyses in a wide variety of scenarios.

=== Availability
Kerblam! is a Free and Open Source Software, available on GitHub at #link("https://github.com/MrHedmad/kerblam")[MrHedmad/kerblam].
Pre-compiled binaries as well as installers are available for machines running Mac-OS and Linux.
The full documentation to Kerblam! is available at #link("https://kerblam.dev/")[kerblam.dev].
Active support for Kerblam! and its future development are guaranteed for the foreseeable future.

= Conclusions
Structuring data analysis projects is a personal matter, heavily dependent on the preference of the individual(s) who run the analysis.
However, best practices arise and can be individuated in this fragmented landscape.

With this work, we aimed at providing such guidelines, and included a robust tool to leverage the regularity of such standardized layout.
As the proposed layout is, for all intents and purposes, largely arbitrary, Kerblam! can be configured to work with any layout.

Through these and potentially future standardization efforts, tools such as containerization and workflow managers can become more mainstream and even routine, leading to an overall more mature and scientifically rigorous way to analyse data of any kind.

/// -----------------------------------------------

= Code and Data availability
The raw data fetched by the analysis of project templates (e.g., list of fetched repositories, detected frequencies, etc...) are available on Zenodo at the following DOI #link("https://doi.org/10.5281/zenodo.13627214").
The code for the analysis is available on GitHub at #link("https://github.com/MrHedmad/ds_project_structure")[MrHedmad/ds_project_structure] and is archived on Zenodo with DOI #link("https://zenodo.org/doi/10.5281/zenodo.13627322")[10.5281/zenodo.13627322].

Kerblam! is available on GitHub at #link("https://github.com/MrHedmad/kerblam") and archived at every release in Zenodo at DOI #link("https://zenodo.org/doi/10.5281/zenodo.10664806").
Its documentation is available at #link("https://kerblam.dev/").

= Author's contributions
Conceptualization: L.V., L.M. and F.A.R., Software: L.V., Methodology: L.V. and F.A.R, Resources and Funding Acquisition: L.M., Writing - Original Draft: L.V., L.M. and F.A.R., Supervision: L.M. and F.A.R.

/// -----------------------------------------------

/*
#pagebreak(weak: true)
#set heading(numbering: "A.1", supplement: "Appendix")
#counter(heading).update(0)
= Full path frequency table
<ax:freq_table>
#todo[Include here the full table (as a link maybe) to the `result.csv` file of the analysis.]
*/

#pagebreak()
#bibliography("resources/refs.bib", style: "resources/nature-no-superscript-square.csl")
