---
layout: post
title: Automate test environment setup
date: 2014-03-19 01:07:05.000000000 +02:00
author: jperala
header-img: "img/post-bg-02.jpg"
comments: true
tags:
- Chef
- Vagrant
- Configuration management
---

Manual installation and configuration of complex test environments can be very time consuming and error-prone. Setup and configuration of test environment with various servers and dependencies (e.g. database, application server, libraries, compilers, etc.) can take anything from hours to several days depending on the environment complexity. Manual configuration is also very error-prone as misconfiguration of the environment may not be directly visible, but can results unpredictable behavior and performance leading to unreliable test results. So why not to automate the setup process to make it fast and reproducible?

In my current project we have been using [Chef](http://www.getchef.com/) configuration management tool for automation of the development and test environments. Shortly put, the Chef is pretty much awesome. Setup time for setting new development/test environment is shortened literally from hours to minutes. With Chef, all developers and testers have also identical environments which significantly reduces the amount of time spent on solving environment related issues.

Chef community provides plethora of cookbooks and recipes to manage commonly used software or you can create your own cookbooks with Ruby. Recipes and attributes can be organized  into roles to manage what gets installed on which node (server). With the Chef’s role and environment configurations the recipes and attributes can be managed to create various types of nodes for different testing needs. As an example *“standalone”* role could be created to install database, file server and application server on single node for functional testing, or separate *“database”*, *“file server”* and *“application server”* roles can be created to setup multi-node test environment for performance testing.

Chef is also very flexible and can be applied for different environments. While you normally have Chef server managing your server nodes, the Chef-Solo can be used to configure your environment without access to Chef server. Combining Chef or Chef-Solo with [Vagrant](http://www.vagrantup.com/) enables creation of local virtual machines (VirtualBox/VMWare) configured with same Chef recipes (which is very handy way to create local development and test environments).

If not yet familiar with Chef configuration management, it is definitely worth to get familiar and start cooking.
