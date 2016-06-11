---
layout: post
title: Overview of hosted CI platforms
date: 2016-06-11 10:23:00.000000000 +02:00
author: jperala
"header-img": "img/post-bg-03.jpg"
published: false
tags:
- Continuous integration
- Continuous delivery
- Infrastruture as code
- TravisCI
- CircleCI
- SnapCI
- HostedCI
- ss
---

Continuous integration (and delivery) pipeline is one of the key enabler for agile development...

Traditionally CI platforms, like Jenkins and Atlassian Bamboo, have been self-hosted in company premises, but in last years there has risen dozens of hosted CI platforms that can be used with very cost-effective pricing plans. Although many large enterprises still prefer to host their own infrastructures due security and other reasons, the hosted platforms provide good alternative...

Another change in the CI context is change towards more automated infrastructure and build configuration. While builds have been traditionally configured manually over web interface, the latest platforms support Infrastruce as Code (IaC) paradigm by allowing configuration of build pipelines via configuration files. In addition, most platforms support RESTfull APIs for configuration and monitoring of the CI environments.

In this post you find a short comparison and overview of latest hosted CI platforms.

TravisCI
--------

+ **Homepage:** [https://travis-ci.com](https://travis-ci.com)
+ **VCS support:** GitHub
+ **Pipeline configuration:** Manual, YAML
+ **Pricing:**
  + Free for Open Source (unlimited build minutes and repositories)
  + Starting at $129/month for private projects (2 concurrent jobs, unlimited build minutes and repositories)
  + Free trial (first 100 private builds free)
  + Student plan (100 free builds per month)
+ **On-Site deployment:** Yes. TravisCI Enterprise plan.
+ **Maturity:**
  + Founded 2011
  + Over 235k user accounts
  + Over 300k open source projects
  + References: Facebook, Heroku, Mozilla, Twitter,...
+ **API:** REST
+ **Browser testing:** SauceLabs, Firefox, PhantomJs

CircleCI
--------

+ **VCS:** GitHub
+ **Pipeline:** YAML
+ **Docker:** yes
+ **On-site:** Yes (CircleCI Enterprise)
+ **Pricing:** Free (unlimited repos and users, 1500 build minutes /month, 1 contaiener, no parallel)
+ **Maturity:**
  + Founded 2011
  + Over 90k user accounts
  + References:
+ **API:** REST
+ **Browser:** SauceLabs
+ **Mobile:** Android, iOS
+ **Other:**
  + SSH access for debugging builds.

SnapCI:
-------

+ **VCS:** GitHub,
+ **Pipeline:** No
+ **Docker:** ?
+ **Pricing:** Free for public repositories (1 parallel build)
+ **On-Site:** No
+ **Maturity:** 2013
+ **API:** REST
+ **Browser testing:** Firefox, Chrome, PhantomJs

Shippable:
----------

+ **VCS:** GitHub, Bitbucket, GitLab (BitBucket to be announced)
+ **Pipeline:** YAML
+ **Docker:** Yes
+ **Pricing:** Free (1 build container, 1 pipeline)
+ **On-Site:** No (Beta)
+ **Maturity:** 2013, 50k+ users
+ **API:** REST
+ **Browser:** xfvb, PhantomJS, Firefox

Codeship:
---------

+ **VCS:** GitHub, Bitbucket, GitLab (BitBucket to be announced)
+ **Pipeline:** No (Currently YAML support only for Docker-based services)
+ **Docker:** Yes (Codeship Jet) Docker plans starting at additional $75/month)
+ **Pricing:** Free (1 build container, 1 pipeline, 100 builds, 5 projects, unlimited teams)
+ **On-Site:** No
+ **Maturity:** 2011, 75k+ users
+ **API:** REST
+ **Browser testing:** Firefox, Chrome, PhantomJs, CasperJs, SlimerJs, SauceLabs
+ **Other:**
  + SSH access for debugging builds.

Wercker:
---------
+ **VCS support:**
+ **Pipeline configuration:**
+ **Pricing:**
+ **On-Site deployment:**
+ **Maturity:**
+ **API:**
+ **Browser testing:**
+ **Other:**
  + tbd


SolanoCI:
---------
+ **Homepage:** [https://www.solanolabs.com](https://www.solanolabs.com)
+ **VCS support:** Git, GitHub, BitBucket, Stash, GitLab, Mercurial
+ **Pipeline configuration:** YAML
+ **Pricing:**
  + Starting at $15/month (2 workers, 10 worker hours)
  + 14-day free trial available
+ **On-Site deployment:** Yes. Solano Private CI
+ **Maturity:**
  + Founded 2011
  + Customer references: AirBnB, New Relic,...
+ **API:** REST
+ **Browser testing support:** Firefox, Chrome
+ **Other:**
  + SSH Debug Console (in Private release)
  + Docker container support


Drone.io:
---------
+ **Homepage:** [https://drone.io](https://drone.io)
+ **VCS support:** GitHub, BitBucket, Google Code
+ **Pipeline configuration:** Manual, YAML
+ **Pricing:**
  + Free for Open Source (unlimited builds and public projects)
  + Starting at $25/month for private projects (unlimited builds, 5 private projects)
  + Free trial (first 50 private builds free)
+ **On-Site deployment:** No. Only hosting plans.
+ **Maturity:**
  + Founded 2012
  + No listed references.
+ **API:**
+ **Browser testing support:** Firefox, Chrome, Chromium, PhantomJS, Xvfb

Appveyor:
---------
+ **Homepage:** [https://www.appveyor.com](https://www.appveyor.com)
+ **VCS support:** GitHub, BitBucket, Visual Studio Online, GitLab, Kiln, Subversion, Git, Mercurial, Stash
+ **Pipeline configuration:** Manual, YAML
+ **Pricing:**
  + Free for Open Source (1 concurrent job, unlimited public projects)
  + Starting at $29/month for private projects (1 concurrent job, 1 private projects)
  + 14-day free trial available
  + 50% discount for student and academic organizations
+ **On-Site deployment:** No. Only hosting plans.
+ **Maturity:**
  + Founded 2011
  + +20k accounts
  + Customer references: Microsoft, Google, Facebook, RackSpace, NASA, Rightscale,...
+ **API:** REST
+ **Browser testing support:** Firefox, Chrome, Internet Explorer

HostedCI:
---------
+ **Homepage:** [https://www.appveyor.com](https://www.appveyor.com)
+ **VCS support:**
+ **Pipeline configuration:**
+ **Pricing:**
+ **On-Site deployment:**
+ **Maturity:**
+ **API:**
+ **Browser testing support:**
+ **Other:**
+ tbd

Semaphore:
---------
+ **Homepage:** [https://www.appveyor.com](https://www.appveyor.com)
+ **VCS support:**
+ **Pipeline configuration:**
+ **Pricing:**
+ **On-Site deployment:**
+ **Maturity:**
+ **API:**
+ **Browser testing support:**
+ **Other:**
+ tbd

Bitrise:
---------
+ **Homepage:** [https://www.appveyor.com](https://www.appveyor.com)
+ **VCS support:**
+ **Pipeline configuration:**
+ **Pricing:**
+ **On-Site deployment:**
+ **Maturity:**
+ **API:**
+ **Browser testing support:**
+ **Other:**
+ tbd

Summary table
=============

|               |VCS Support|Platform(s)|IaS|Pricing|API|Maturity|Browser Testing|Docker Support|Private installation|
|**TravisCI**   | GitHub    |           | YAML |       |   |        |               |              |                    |
|**CircleCI**   |           |           |   |       |   |        |               |              |                    |
|**SnapCI**     |           |           |   |       |   |        |               |              |                    |
|**Shippable**  |           |           |   |       |   |        |               |              |                    |
|**Codeship**   |           |           |   |       |   |        |               |              |                    |
|**Wercker**    |           |           |   |       |   |        |               |              |                    |
|**SolanoLabs** |           |           |   |       |   |        |               |              |                    |
|**Drone.io**   |           |           |   |       |   |        |               |              |                    |
|**AppVeyor**   |           |           |   |       |   |        |               |              |                    |
|**HostedCI**   |           |           |   |       |   |        |               |              |                    |
|**Semaphore**  |           |           |   |       |   |        |               |              |                    |
|**Bitrise**    |           |           |   |       |   |        |               |              |                    |
