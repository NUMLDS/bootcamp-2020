# intro-shell

We'll roughly follow along with Software Carpentry's [Unix Shell lesson](http://swcarpentry.github.io/shell-novice/). 

Download the data at: https://bit.ly/intro-shell-data You can do this right in the terminal:

```bash
$ wget bit.ly/intro-shell-data
```

# Bash outline

1. Introduction
    * Motivation: why learn the shell?
        * The shell is the most general toolbox in the computing world
        * It's much, much more dominant than you think
        * Concepts from the shell pop up everywhere in computing
        * The shell allows you to solve many common problems yourself without having to wait on an IT person
        * Analytics trends come and go, but Bash is forever.
    * History of Unix and the prevalence of the shell
        * UNIX was developed in the 1970s at Bell Labs. Like other operating systems at the time, 
        it was proprietary, but AT&T licensed it to other vendors who made their 
        own OSes from it, all of which shared many common properties, allowing the computing world 
        to begin to standardize on a way of interacting with operating systems. Some of these 
        lineages are still around, but you probably don't need to worry about them.
        * True Unixes were really expensive and not accessible to individuals. BSD and Linux arose
        as free and open source Unix clones. Today, Linux dominates
            * most public web servers and other internet infrastructure
            * most data analysis environments and almost all high-performance clusters
            * embedded devices and the entire Internet of Things
            * Android and ChromeOS, which are Linux distributions
        * Basically every operating system you interact with is Unix-based, except for Windows.
        * BSD itself is less common, but it forms the basis of Apple's entire line of OSes.
        * Today many people use Unix and Linux synonymously
    * Unix philosophy:
        * everything is a file
        * programs should do one thing and do it well
        * programs should operate on text streams because it is a universal interface
            * This means the Unix shell is not object-oriented. To get the current day of week, in Bash:
            ```bash
            [meineke@mycomputer ~]$ date
            Tue Nov 27 11:10:48 CST 2018  # this is just text
            [meineke@mycomputer ~]$ date +%A # this just changes text formatting
            Tuesday
            ```
            
            Whereas in Powershell, the  `get-date` command returns an object:
            ```
            PS C:\Users\lewis> get-date

            Tuesday, November 27, 2018 11:09:29 AM  # this is an object with a bunch of methods available

            PS C:\Users\lewis> $(get-date).IsDaylightSavingTime()
            False
            PS C:\Users\lewis> $(get-date).AddMonths(-3).IsDaylightSavingTime()
            True
            ```
    * terminology: 
        * Unix: a family of operating systems defined by their adherence to a specific 
        set of standards for how to interact with them
        * Linux: a free and open source Unix-like operating system (technically only the kernel)
        * Linux distro: a full operating system that packages the Linux kernel with other tools. 
        Common Linux distros are Red Hat, CentOS, Ubuntu, Debian, SUSE, etc.
        * shell: a special program that receives text input, passes commands to the OS, and sends 
        the output to the user (or anywhere else the user wants to send output to). The shell is the 
        main interface between the user and the operating system.
        * terminal: a program that displays shells and handles things like tabs, fonts, colors, 
        custom keyboard shortcuts, etc.
        * Bash: the default shell for regular (non-admin) users on most Unix-like OSes

2. Basic commands
    * `pwd`, `whoami`, `hostname`, `ls`, `ls -l`, `echo`, `which`
    * `Ctrl + C`, for example to escape `echo "hello`
    * `cd`, intro to paths
    * `/ ~ . ..`
    * `mkdir`, `cp`, `mv`: practice with paths
    * `rm` *careful with this one*
    * anatomy of a shell command: prompt, command, option, argument, cursor 
    ![shell_command](https://softcover.s3.amazonaws.com/636/learn_enough_command_line/images/figures/anatomy.png "Anatomy of a shell command")
    * `cat`
    
3. Shortcuts: typing in Bash is fast
    * A lot of this works outside the terminal!
    * Tab completion
    * Double-tap tab to see options
    * `↑` and `↓`
    * `Ctrl + ←/→`  to skip words
    * `Alt + Backspace` to delete words
    * `Ctrl + A`, `Ctrl + E` to go to beginning/end of line
    * `Ctrl + R` to search history
    * `Ctrl + C` to cancel
    
4. Making and editing files
    * `touch`
    * `echo 'something' > somefile`
    * `echo 'something else' >> somefile`
    * `nano`, `vim`
    
# Resources

## Tutorials

### Introductory/General

#### My favorites

[Learn Enough Command Line to Be Dangerous](https://www.learnenough.com/command-line-tutorial) by Michael Hartl. Maybe my favorite intro to the subject because he's generally good at emphasizing what is actually useful. The only bad bit is his MacOS proselytizing, which is not very helpful. Bash is for Windows users too!

[DataCamp: Introduction to Shell for Data Science](https://www.datacamp.com/courses/introduction-to-shell-for-data-science): Free online course from DataCamp

[Software Carpentry Command Line Workshop](http://swcarpentry.github.io/shell-novice/): workshop materials you can work through on your own; there are videos of instructors giving the workshop at: [video 1](https://www.youtube.com/watch?v=hAHJ0xGKMBk) and [video 2](https://www.youtube.com/playlist?list=PLkBeePYo-_VCXtMNGDboOL66V-P2-jAoM)

[explainshell.com](https://explainshell.com) will explain any shell command you type into it! Great for demystifying shell commands.

#### But also

[Conquering the Command Line](http://conqueringthecommandline.com/book) by Mark Bates is organized by command with subsections organized by the options for the commands.  Makes for a clear reference with easy to navigate table of contents.

[Command Line Bootcamp](http://rik.smith-unna.com/command_line_bootcamp): an interactive tutorial in your browser, with all the essentials, by Richard Smith-Unna

[Code Academy: Learn the Command Line](https://www.codecademy.com/learn/learn-the-command-line): interactive, online tutorial; you can access the basic content for free, but not the exercises.  A good, quick introduction to the basics like listing files and changing directories.

[Practical Unix](http://openclassroom.stanford.edu/MainFolder/CoursePage.php?course=PracticalUnix): good reference for learning lots about using the command line environment, beyond what is covered in this workshop.

[Unix Tutorial for Beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/)

[The Art of Command Line](https://github.com/jlevy/the-art-of-command-line): tutorial and reference to teach you the most common commands and tasks, with an awareness of differences with Mac and Windows

[The Unix Workbench](http://seankross.com/the-unix-workbench/) by Sean Kross, teaches multiple technologies that you use from the command line, including git and bash scripting.  There is also a [Coursera course of the same name](https://www.coursera.org/learn/unix).

## Cheat Sheets/Reference Sheets

[Command Line Cheat Sheet](https://www.git-tower.com/blog/command-line-cheat-sheet/) with just the essentials, plus short explanations of key concepts

[Linux Command Line Cheat Sheet](https://www.cheatography.com/davechild/cheat-sheets/linux-command-line/): another useful version with the essentials, plus some intermediate commands

[vi Handout](https://nuitrcs.github.io/commandlineworkshop/vibasics.pdf): handout from the workshop

[vi Basics](https://www.cs.colostate.edu/helpdocs/vi.html): a good short intro explaining vi and a list of common commands, with the key commands highlighted.

[VI Cheat Sheet](https://www.gosquared.com/resources/vi-cheat-sheet/): for using the VI command line text editor

[Software Carpenty's Shell lesson](http://swcarpentry.github.io/shell-novice/) is a pretty good resource for getting the basics. You can probably ignore the parts on loops and scripts, unless you haven't learned these concepts in another programming language.


