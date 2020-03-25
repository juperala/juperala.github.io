---
layout: post
title: How to run Robot Framework from command line?
date: 2020-03-25 17:23:00 +02:00
author: jperala
"header-img": "img/post-bg-07.jpg"
published: true
comments: true
tags:
- Robot Framework
- Tutorial
- Command Line Interface
---

Yesterday a colleague learning test automation forgot the syntax for running Robot Framework test cases from command-line. Although full command-line syntax is described on the [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html){:target="_blank"} it is rather long and tedious document to dive into.

This post aims to provide quick introduction for executing single, set or all Robot Framework test cases in a project.

# Basic syntax

The basic syntax for executing Robot Framework tests from command line is:

{% highlight sh %}
    # basic syntax
    robot [options] robot_files

    # example with options
    robot -v URL:http://example.com example.robot
{% endhighlight %}

For full list of command-line options see `robot --help` or `robot -h` option.

# Execute all test cases in folder(s)

To run all robot tests in the folder (including subfolders) use `.`

{% highlight sh %}
    # execute all tests in all robot files in current folder and subfolders
    robot .
{% endhighlight %}

# Execute all test cases in single file

To run all robot tests in single robot file:

{% highlight sh %}
    # execute all tests in single robot file in current folder
    robot example.robot

    # execute all tests in single robot file in subfolder
    robot path/to/example.robot
{% endhighlight %}

# Execute test cases by test name

To run test cases with specific test name use `--test` or `-t` option: 

{% highlight sh %}
    # execute test cases with name "Example" in any file.
    robot --test Example .

    # execute test cases with name "Example" in specific file.
    robot --test Example example.robot
{% endhighlight %}

Also partial test names and patterns can be used with `--test` option, see [Using partial names and filter patterns](#using-partial-names-and-filter-patterns).

# Execute test cases by tags

Test cases and suites annotated with tags (using `[Tags]` or `Force Tags` syntax) can be executed by selecting tags to be *included* or *excluded*.

Example test suite:
{% highlight robotframework %}
    *** Settings *** 
    Force Tags  suite

    *** Test Cases ***
    Test One
        [Tags]  one
        No operation

    Test Two
        [Tags]  two
        No operation
{% endhighlight %}

Also partial tag names and patterns can be used with `--include` and `--exclude` option, see [Using partial names and filter patterns](#using-partial-names-and-filter-patterns).

## Include test cases by tag

To run test cases with specific tag name included use `--include` or `-i` option: 

{% highlight sh %}
    # execute test cases with tag "one" in any file.
    robot --include one .    

    # execute test cases with tags  "one" and "two" in any file.
    robot --include oneANDtwo .    

    # execute test cases with tag "one" or "two" in any file.
    robot --include oneORtwo .    

    # execute test cases with tag "one" but without tag "two" in any file.
    robot --include oneNOTtwo .    
{% endhighlight %}

## Exclude test cases by tag

To run test cases with specific tag name excluded use `--exclude` or `-e` option: 

{% highlight sh %}
    # execute test cases without tag "two" in any file.
    robot --exclude two .
{% endhighlight %}

# Execute test cases by suite name

In *Robot Framework* test folders and `.robot` files are considered as test suites.

Example suite structure:
{% highlight sh %}
  - +-+- tests
  -   +-+- feature1
  -   | +--- positive.robot
  -   | +--- negative.robot
  -   +-+- feature2
  -     +--- positive.robot
  -     +--- negative.robot
{% endhighlight %}

To run test cases in specific test suiteuse `--suite` or `-s` option: 

{% highlight sh %}
    # execute test cases from suites named "positive" in any file.
    robot --suite positive .

    # execute test cases from suite "feature1\positive" in any file.
    robot --suite feature1.positive .
{% endhighlight %}

Also partial suite names and patterns can be used with `--suite` option, see [Using partial names and filter patterns](#using-partial-names-and-filter-patterns).

# Execute failed tests

There is also possibility to rerun all failed test cases and test suites.

## Execute only failed test cases

To rerun failed test cases use `--rerunfailed` or `-R` option: 

{% highlight sh %}
    # execute test cases failed in previous run (saved in output.xml)
    robot --rerunfailed output.xml .    
{% endhighlight %}

## Execute failed test suites

To rerun test suites with failed test cases use `--rerunfailedsuites` or `-S` option: 

{% highlight sh %}
    # execute test cases with failed test cases in previous run (saved in output.xml)
    robot --rerunfailedsuites output.xml .    
{% endhighlight %}

# Using partial names and filter patterns

The presented `--test`, `--suite`, `--include` and `--exclude` options also support using partial names and filter patterns to match multiple names and tags:

{% highlight sh %}
    # execute test cases containing name "Example" in any file.
    robot --test *Example* .

    # execute test cases "Example One" and "Example Two" in any file.
    robot --test "Example [One|Two]" .

    # execute test cases with tags starting with "One" in any file.
    robot --include One* .

    # execute test cases without tags ending with "Two" in any file.
    robot --exclude *Two .

    # execute test cases from suites starting with "positive" in any file.
    robot --suite positive* .
{% endhighlight %}

For full list of supported filter patterns see User Guide section [Simple Patterns](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#simple-patterns){:target="_blank"}

# Combining filters

The presented `--test`, `--suite`, `--include` and `--exclude` options can be used also in combination:

{% highlight sh %}
    # execute test cases containing name "Example" and having tag "One" in any file.
    robot --include One --test *Example* .

    # execute test cases from suite "FeatureA" exluding tests with tag "Smoke" in any file.
    robot --suite FeatureA --exclude Smoke .

    # execute test cases with tag "Pending" from specific file.
    robot --exclude Pending example.robot
{% endhighlight %}
