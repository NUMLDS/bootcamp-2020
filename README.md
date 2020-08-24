# 2020 MSiA boot camp

This Github repository contains materials for the R sessions of the 2020 Masters of Science in Analytics program boot camp, including lecture notes, slides, exercises, and recommended resources as you continue to develop your skills. 

## Workshop materials

|Session|Content|Lecture notes|Slides|Exercises|
|-------|-------|-------------|------|---------|
|Day -1<br />Mon, 8/24|Intro to the Shell|[Lecture Notes](https://msia.github.io/bootcamp-2020/lecturenotes/day0_shell_lecturenotes)|||
|Day 1<br />Wed, 8/26|Basic syntax and data structures; reading and writing files|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day1_syntax-fileIO_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day1_syntax-fileIO_slides.html)|[Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day1_syntax-fileIO_exercises.R) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day1_syntax-fileIO_exercises_with_answers.R)|
|Day 2<br />Thur, 8/27|Data manipulation and simple visualization in base R|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day2_dataintro_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day2_dataintro_slides.html)|[Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day2_dataintro_exercises.R) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day2_dataintro_exercises_with_answers.R)|
|Day 3<br />Wed, 9/2|Loops, conditionals, and functions|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day3_loops-conditionals-functions_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day3_loops-conditionals-functions_slides.html)| [Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day3-loopsconditionalsfunctions-exercises.R) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day3-loopsconditionalsfunctions-answers.Rmd)
|Day 4<br />Thur, 9/3|Git workflow in Rstudio/R Markdown; Reshaping and merging|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day4_Rmd-datamanip1_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day4_Rmd-datamanip1_slides.html)|[Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day4_Rmd-datamanip1_exercises.Rmd) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day4_Rmd-datamanip1_exercises_with_answers.Rmd)|
|Day 5<br />Tue, 9/8|Advanced data manipulation in dplyr|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day5_dplyr_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day5_dplyr_slides.html)|[Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day5_dplyr_exercises.Rmd) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day5_dplyr_exercises_with_answers.Rmd)|
|Day 6<br />Wed, 9/9|Advanced data manipulation in data.table|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day6_datatable_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day6_datatable_slides.html)||
|Day 7<br />Thur, 9/10|Data visualization with ggplot2|[Lecture notes](https://msia.github.io/bootcamp-2020/lecturenotes/day7_ggplot_lecturenotes)|[Slides](https://msia.github.io/bootcamp-2020/lectureslides/day7_ggplot_slides.html)|[Exercises](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day_7_ggplot_exercises.Rmd) and [Answers](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day_7_ggplot_exercises_with_answers.Rmd) |
|Day 8<br /> Tue, 9/15|Final exercise|||[Instructions](https://github.com/MSIA/bootcamp-2020/blob/master/exercises/day8_final-exercise-instructions.md)|

## Resources

### Shell

NUIT's [command line workshop](https://github.com/nuitrcs/commandlineworkshop) includes some exercises and a well-curated list of resources. I'll add some commentary on what resources I think are useful for data analysts who need a working understanding of Bash, shells, and Unix.

Software Carpentry's [Unix Shell](http://swcarpentry.github.io/shell-novice/) course is a useful and matter-of-fact introduction. It probably won't convince you just how broadly useful the shell really is, though.

[Learn Enough Command Line to be Dangerous](https://www.learnenough.com/command-line-tutorial), by Michael Hartl, is an excellent and realistic introduction with good exercises. I wish it had existed when I started learning this stuff. My only quibble is that the author is a macOS proselytizer, which I find unhelpful and out of step with the current landscape--Bash is for Windows users too!

Once you're comfortable with that, you can follow it up with [Learn Enough Text Editor to be Dangerous](https://www.learnenough.com/text-editor-tutorial). This might not be that exciting, but practicing this stuff will make you faster and more productive.

If you'd like a really accessible intro to the nuts and bolts of how all this stuff actually works, I like [Julia Evans'](https://twitter.com/b0rk) work. She [writes](https://jvns.ca/) a blog as well as ingenious [comics](https://twitter.com/i/moments/1026078161115729920) that teach Linux and Bash.

If you liked the DataCamp introductory R course, they also offer a free [shell course](https://www.datacamp.com/courses/introduction-to-shell-for-data-science).

### Git

Software Carpentry's [Version Control with Git](http://swcarpentry.github.io/git-novice/) course is what we followed along with earlier. Like their Bash course, it doesn't really introduce you to a real-world workflow, but it does help you understand the basic mechanics in a straightforward way.

Michael Hartl also wrote [Learn Enough Git to be Dangerous](https://www.learnenough.com/git-tutorial). Just like his Bash and Text Editor tutorials, this is great for developing a practical understanding of the parts of Git that you really need to know.

NUIT also has a [Git resource list](https://github.com/nuitrcs/gitworkshop).


## Authorship

The R materials used on 8/26 - 9/8 and 9/10 are based on the [Intro to R workshop](https://github.com/nuitrcs/r_intro_june2018) from NUIT Research Computing Services, created by Christina Maimone. They have been expanded and modified by Kumar Ramanathan and Richard Morel. The materials on data.table used on 9/18 were originally developed by Ali Ehlen. The materials on ggplot2 used on 9/10 were originally developed by Kumar Ramanathan. Richard Morel, Ali Ehlen, and Kumar Ramanathan all jointly developed the overarching sequence of the sessions as well as the synthetic final exercise on 9/15. 

## Contact information

- Kumar Ramanathan: [Email](mailto:kumar.ramanathan@u.northwestern.edu) | [Website](http://www.kumar.fyi)
- Richard Morel: [Email](mailto:richard.morel@u.northwestern.edu) | [Website](http://ramorel.github.io)
- Ali Ehlen: [Email](mailto:AnnalieseEhlen2020@u.northwestern.edu)
- Emilio Lehoucq: [Email](mailto:emilio-l@u.northwestern.edu) | [Website](https://emiliolehoucq.com/)
- Sarah Moore: [Email](mailto:sarahmoore2022@u.northwestern.edu) | [Website](https://blogsarahmoore.wordpress.com/)
- Amanda Sahar d'Urso: [Email](mailto:asdurso@u.northwestern.edu) | [Website](https://sites.northwestern.edu/asdurso/)
