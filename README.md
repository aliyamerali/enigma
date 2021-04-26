## Enigma
Turing Mod 1 Independent Project.   
   * Project details [here](https://backend.turing.edu/module1/projects/enigma/)
   * Class, module, and method descriptions [here](https://docs.google.com/spreadsheets/d/1AdLbTNUh2KaiZHzzMIwzNOTh9tHuZ24j1iTbzbfKqlg/edit?usp=sharing)

#### Self Assessment

|Category|Score|Explanation|
| ------------- | ------------- | ------------- |
|Functionality| 4 | Functionality is fully implemented.|
|OOP| 3.5 | Multiple modules implemented, classes and methods are responsible for single responsiblities. Methods are reasonably sized, though some are slightly longer than 10 lines. I feel good about the code organization, though I'm not certain this is the "best" option. |
|Ruby Conventions and Mechanics| 3.5 | Indentation and formatting is in good shape, and I did my best to be thoughtful about class, module, method, and variable names. Some methods are slightly longer than 10 lines. I believe most enumerables chosen were most efficient for the job at hand, though I did use #each_with_index quite a bit and was unable to find a better option, though I suspect there may be.| 
|TDD| 3.5 | Test coverage is at 100% for all but the CLI runner files (which brings total coverage down to 88%). Mocks and stubs were implemented in the FromFileable module to focus the test on the read/write functionality and take out the need to run encrypt/decrypt methods for efficiency. |
