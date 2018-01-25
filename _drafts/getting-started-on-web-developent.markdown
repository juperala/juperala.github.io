---
layout: post
title: Getting started on Web Developement
#date: 2014-02-16 02:26:36.000000000 +02:00
author: jperala
header-img: "img/post-bg-01.jpg"
comments: true
---
<p>It kind of shocked me to realize that I've never really developed frontend web applications - There just haven't been any need for it. For the most of my career I've worked on job roles related to test automation. That includes plenty of programming and development on daily basis, but all the development I do is for testing. Meaning things like writing automated tests using frameworks such Selenium, JUnit and Robot Framework; creating automation scripts for setting up test environments; developing test tools; and so on. I've also worked purely on development roles, but always related to embedded or backend development.</p>

<p>Inspired by this I decided to start an side-project to get more familiar on developing frontend applications with modern tools. It would give me also a great opportunity to try out cloud platforms and their benefits from app development perspective - for now I've used cloud platforms only for testing related tasks.</p>

<p>Here's story of what I did and thoughs throughout the learning path. The post does not aim to be a step-by-step tutorial, but rather give an overview of what to look into when starting frontend web development.</p>

## The Goal
<p>I wanted to develop some application that could potentially be somewhat usefull for others also. Maybe something that uses Open Data.</p>

<p>Few years ago a massive undeground parking station (Kivisydän) was opened in Oulu and I've always been kind of curious does it ever get fully crowded. As it happens to be, the City of Oulu exposes the realtime utilization of parking stations as [Open Data](https://data.ouka.fi) API, so I decided to write an application that would store this information and show the parking stations current utilization and statistics in a web application.</p>

<p>As I wanted to store the utilization information for statistics, It was clear that I would need to implement the frontend application that shows this information, and also backend functionality that fetches data from public API, stores it database and provides API to query stored data by the frontend application.</p> 

## What tools for what?
<p>Getting started on web development can be a bit painful. Even though I have plenty background with other programming and as a tester I've worked a lot with web apps to know solid basics of HTML markups and CSS styling, it wasn't fully clear what tools and libraries I need to get started. As a newbie it kind of feels that there is dozen of "X.js" libraries and tools for everything and I felt bit unsure to know what to use.</p>

<p>One of the best resources describing the current status in web dev that I found was Matt Raible's Devoxx talks ["Front Ends for Back End Developers"](https://www.youtube.com/watch?v=AjzyV8BraIs). That was definitely worth watching.</p>

<p>After a bit of googling and familiarization, it started to look that the things I would probably need to choose or atleast be aware of are:
+ Programming language
+ Application Framework
+ Dependency management tool
+ Build tool
+ Test tools
+ Bundler
+ Transpiler
+ Deployment environment,
++ Serving static frontend app
++ Running the API functionality and database.
</p>

### Programming language
<p>With programming languages you have few options, whether to use plain JavaScript or some alternate language like TypeScript that compiles into JavaScript. With Java background I am more used to languages with static types so TypeScript sounded like an safe way to go. However, to start with the basics I decided to use plain JavaScript, after that it would be straighforward to start using other JavaScript-compilable languages also.</p>
<p>What comes to JavaScript, it's also good to be aware of alternate versions supported. The ES5 is the "old-school" JavaScript supported by pretty much every browser. The ES6 (ES2015) changed the syntax quite a bit and introduced entities like classes to JavaScript. Also ES6 is nowadays well covered, but features introduced in ES2016 and beyond may not work on all browsers and environments (see compatibility). The good thing is, that even the newer features can be used with transpilers (e.g. Babel) that rewrite the code to be compatible with older JavaScript versions.</p>
<p>Besides JavaScript and TypeScript, there is also other languages to look into such ELM, PureScript, ClojureScript, CoffeeScript, and so on. Be open-minded and try what fits you the best.</p>

### Application Framework
<p>You can develop applications with plain (vanilla) JavaScript, but most projects use some kind of web framework for project structure. The top-3 currently seems to be React, Angular and Vue.js. For any of these you are likely to find good community support with examples, forums, etc. There is also endless amount of other frameworks, Meteor, Ember.js and Cycle.js to mention few.</p>

<p>For my project I chose React due it's wide popularity and having colleagues with experience on it.</p>

### Dependency & Build Tools
<p>When developing your application you need to somehow manage and download the needed dependencies and tools. For this you most likely end-up using npm or yarn. Npm is the good 'ol package manager that most tutorials seems to be using. Yarn is newer tool aiming to solve some problems and performance issues npm has.</p>

<p>Both npm and yarn can be also as build tools by running project-specific scripts with run command. In addition there is dedicated task runner tools like Gulp and Grunt to carry out more complex build tasks.</p>

<p>In my project I ended using npm but will move to yarn for future versions.</p>

### Test tools
<p>For testing your application there is an variety of JavaScript based test tools available that integrate into your build configuration. Some potential testing tools to checkout:
- Jest - default test with React's create-react-app. Works with any JavaScript code.
- Protractor - End-to-end testing framework for Angular applications.
- Jasmine - Behaviour driven development framework for testing JavaScript. Works with any JavaScript code.
- Cypress.io -  Complete end-to-end testing for anything running in browser.
- Nightwatch.io - Browser automated testing done easy.
</p>

<p>I used Jest that came preconfigured with React's create-react-app.</p>

### Bundler
<p>When you want to run your application in a browser, you need to deliver all the dependent code modules to be able to execute your code. In very small projects with minimal dependencies you could just include your scripts as is, but for anything bigger you want to bundle up your code (and resources) to minimize the http requests and size of file downloads. For this there is tools such Webpack and Browserify.</p>

<p>I used Webpack that came preconfigured with React's create-react-app.</p>

### Transpiler
<p>When using the latest features not yet supported by all targeted browsers, you may need to transpile the code to be compatible with older JavaScript versions. Babel is the de-facto tool to do it.</p>

## Cloud Deployment
<p>...AWS.</p>

### Domain & DNS
<p>AWS Route53</p>

### Security & SSL Certificate
<p>Certificate Manager.</p>

### Content Distribution
<p>AWS Cloudfront.</p>

### Hosting Static Content
<p>AWS S3.</p>

### API Functions & Deployment
<p>AWS Lambda + API Gateway.</p>

### Database
<p>AWS DynamoDB.</p>

## Developing the application

### Frontend React app

### Backend APIs

## The Result: oulunparkit.com
<p>AWS DynamoDB.</p>

## Wrap-up
<p>AWS DynamoDB.</p>

