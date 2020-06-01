# python-cli

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io#https://github.com/da-moon/python-cli)

## overview

> TO FILL

### rationale

> TO FILL

### cli

helps with quickly bootstrapping a python data-science related library and cli project

## components

- [x] cli
    - [x] cli entry point
    - [x] main class
- [ ] artificial intelligence and data-science pipeline
    - [ ] data acquisition framework
    - [ ] data normalization framework
    - [ ] error rate and analysis framework
    - [ ] cli entry point template
    - [ ] algorithm main class template
    - [ ] example on how to use with jupyter notebook 
- [ ] optimization pipeline
    - [x] benchmark framework and optimization functions and problems
        - [x] Schaffer
        - [x] Eggholder
        - [x] Booth
        - [x] Matyas
        - [x] Cross
        - [x] Levi
    - [x] plot framework
        - [x] animated scatter plot
    - [x] csv export framework
    - [ ] cli entry point template
    - [ ] orchestrator class template
    - [ ] search agent class template
    


## build

### build-common-targets

- `make python-run` : runs sub-commands with different flags
- `make clean` : cleans repository
- `make init` : upgrades pip,installs pip packages and sets the repository to develop mode. this is called by gitpod at start of the container
- `make python-develop` : sets repository to develop mode. must be called after activating environment. if not , python would not be able to run any scripts.
- `make python-add-shebang` : searches repository recursively for all files that end in `*.py` . checks to see if python3 shebang is added. if not, then it would add the shebang to start of the file. It need `bash >=4` since it calls a script at `$(PWD)/contrib/scripts/add_shebang`

### build-common variables 

pipeline's variables are defines in `vars.mk` at repository's root which allows user to modify
pipeline's execution sequence and commands.

the following are common variables :

- `Log_LEVEL` controls verbosity of logs in `STDOUT`. at the moment , logs only have `INFO` , `DEBUG`  levels

### build-cli

> TO FILL

### build-artificial-intelligence

> TO FILL

### build-metaheuristics 

- `PLOT` by setting `PLOT` to true , an animated scatter plot will be created. 
- `EXPORT_ROOT` : controls the parent directory that all csv exports would be stored in. If empty, then the would be no csv output. default value is `export` , meaning all csv files would be stored under `$(PWD)/export`

the following are make targets :

- `make subcommand-*` : runs a specific benchmark with subcommand algorithm. replace `*` with one of the following : `schaffer eggholder booth matyas cross levi`

the following are some pointers regarding Gitpod environment:

- if `Plot` value is set to true, then output would be in in the website running at port `6080` of Gitpod container. the website is in fact what gets opened in the right hand pane of Gitpod workspace right after opening the repository in Gitpod. I would suggest you to open the website in another tab of the browser rather than keeping it as a Gitpod pane so that outputs are seen easier. 
- if `Plot` value is set to true, it would be better to use the following for `run` target : `make -j2 run` . Using this option makes sure gnu make runs two targets in parallel, making it easier to see plot outputs
- if `Plot` value is set to false, and you are exporting output to csv, it would be better to use the following for `run` target : `make -j$(nproc) run` . Using this option makes sure gnu make runs a target per core , which in case of Gitpod is `16` parallel targets at a moment, increasing output speed tremendously. 
- when opening a csv file , press `ctrl+shift+p` and in the opened bar, search for `convert table from csv` . It make the csv file much more readable
- vscode convert-case extension has been added to environment , making it easier to refactor and change names. to change a variable name, press `ctrl+shift+p` and search for `convert case`
- holding `alt` and clicking allows for multi-line cursors . 
- pressing `ctrl+x` would cut the whole line , no need to highlight the line by hand
- pressing `ctrl+f` searches in file while pressing `ctrl+shift+f` searches all the files in the repository. be vary careful of replacing text because Gitpod has a bug that sometimes turns the replaced text into gibberish. safest way to search and replace in the whole repository is to close all opened files and then run the search.


## package structure

### common

- `utils/benchmarks.py` contains benchmark functions used for evaluating optimization algorithms. target value ( optimization goal ) of each benchmark function is written as a comment

### metaheuristics and optimization problems

Main entry point of the package is `project_template/__main__.py` . Every sub package contains `main.py` , `<algorithm name>.py` ,  `<algorithm name>_problem.py` and it can also have a `benchmarks.py` file. 

Main entry-point essentially builds a cli and exposes subcommands for different optimization algorithm . At this point only Whale Optimization is supported. 

a subcommand's CLI options and parser is in `<algorithm name>/main.py` and that file creates a new instance of class defined in `<algorithm name>_problem.py`.

`<algorithm name>_problem.py` is the file in which acts as problem's (algorithm's) orchestrator . for instance, in case of whale optimization, it is the class that holds information needed to run the algorithm but there is no need for those information to be included in each whale class. `solve` function is the main method that solves/optimizes a problem.
Keep in mind that only top solution is printed unless you set log level to `INFO` or below.
Keep in mind that this is the main function needed for running the algorithm, meaning it can be imported by other libraries as long as the input is compliant with what it expects.

`<algorithm name>.py` is the file that holds methods an functions that is supposed to run individually by each search agent.
in general , there are two methods of `exploration_phase` and `exploitation_phase` per algorithm that encompass other methods and functions as defined in an algorithm corresponding paper

## workflow

> TO FILL

## contribution

- create a new git branch from master branch by running `git checkout -b feature/<branch name>` . 
- do not push to master branch directly
- commit as frequently as possible. try to have `atomic` commits,eg. commits that have only one file or very small number of files. It would make process of reviewing pull requests much more robust and easier, also , you can revert back in case of a mistake to a working state with a higher granularity.
