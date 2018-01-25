---
layout: post
title: Testing in the air - Introduction to RF test instrument automation
#date: 2014-02-16 02:26:36.000000000 +02:00
author: jperala
header-img: "img/post-bg-01.jpg"
comments: true
---
<p>When developing a mobile phone, wireless sensor node or any other wireless network element it is not enough to test only the system high-level behavior. To verify the correctness of the telecommunication hardware and low-level software modules it is necessary to verify and measure the actual physical layer communication in different air interface conditions. This is achieved by using various laboratory test instruments (e.g., vector signal generators, signal analyzers and attenuators) in a test bed where the system behavior can be verified in different conditions and with presence of different interference signals and networks.</p>
<p>From time to time I am involved in this type of R&amp;D projects where there is need to develop automated test environment for RF testing. For a software testers typically working in high-level testing (e.g.  UI and Web Service testing), getting started with RF testing and test environment automation can be a tedious task.  Although test instrument manufacturers do provide good level of documentation for automating test instruments, the availability of community resources and examples is rather limited when compared to more popular test tools such Selenium, JUnit, etc.</p>
<p>In this blog post I try to clarify different options for implementing automation of RF test instruments.</p>
<p>Communication: GPIB (IEEE- 488), ethernet (VXI-11, raw socket), USB (USB-TMC), Serial port</p>
<p>VISA</p>
<p>IVI</p>
<p>Python: python-ivi, pyVisa</p>
