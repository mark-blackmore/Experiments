Lecture 13 for Hadley Wickham's STAT 405 at Rice String Processing
================
Mark Blackmore
2017-10-01

``` r
library(knitr)
```

String Processing
-----------------

1.  Motivation: classify spam
2.  String basics
3.  stringr package

### Emails

Examine the structure of emails and basic string processing

``` r
file_URL <- "http://stat405.had.co.nz/data/email.rds"
contents <- readRDS(gzcon(url(file_URL)))
str(contents)
```

    ##  chr [1:200] "Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.219"| __truncated__ ...

``` r
head(contents)
```

    ## [1] "Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Tue, 20 Nov 2001 09:03:18 -0600\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: FW: Govt Affairs Org Chart\nDate: Tue, 20 Nov 2001 09:03:18 -0600\nMessage-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nX-MS-Has-Attach: yes\nX-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nThread-Topic: Govt Affairs Org Chart\nThread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g\nFrom: \"Dietrich, Janet\" <Janet.Dietrich@ENRON.com>\nTo: \"Kitchen, Louise\" <Louise.Kitchen@ENRON.com>\nReturn-Path: Janet.Dietrich@ENRON.com\n\n\n\n -----Original Message-----\nFrom: \tSteffes, James D.  \nSent:\tMonday, November 19, 2001 6:12 PM\nTo:\tDietrich, Janet\nCc:\tShapiro, Richard\nSubject:\tGovt Affairs Org Chart\n\nJanet --\n\nHere is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.\n\nTotal headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    \n\nPlease let me know if you have any questions.\n\nJim"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    ## [2] "Recieved: from nahou-mscnx06p.corp.enron.com ([192.168.110.237]) by NAHOU-MSMBX01V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Mon, 19 Nov 2001 23:27:31 -0600\nReceived: from corp.enron.com ([192.168.110.224]) by nahou-mscnx06p.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Mon, 19 Nov 2001 23:27:31 -0600\nReceived: from mailman.enron.com (unverified) by corp.enron.com\n (Content Technologies SMTPRS 4.2.1) with ESMTP id <T5753582523c0a86ee057c@corp.enron.com>;\n Mon, 19 Nov 2001 23:27:20 -0600\nReceived: from independent.org (dnai-216-15-109-150.cust.dnai.com [216.15.109.150])\n\tby mailman.enron.com (8.11.4/8.11.4/corp-1.06) with SMTP id fAK5REV10291;\n\tMon, 19 Nov 2001 23:27:17 -0600 (CST)\nReceived: from pop.independent.org by independent.org with POP3; Mon, 19\n Nov 2001 18:11:50 -0800\nDelivered-To: swan001-Lighthouse@independent.org\nMime-Version: 1.0\nX-Sender: swan001.mailadmin@pop.independent.org\nMessage-Id: <a05100300b81f6c349681@[216.15.109.150]>\nDate: Mon, 19 Nov 2001 18:11:01 -0800\nTo: \"Lighthouse\" <Lighthouse@independent.org>\nFrom: \"David J. Theroux\" <DJTheroux@independent.org>\nSubject: THE LIGHTHOUSE: November 19, 2001\nContent-Type: text/plain; charset=\"iso-8859-1\" ; format=\"flowed\"\nContent-Transfer-Encoding: quoted-printable\nSender: <Lighthouse@independent.org>\nPrecedence: Bulk\nReturn-Path: Lighthouse@independent.org\n\nTHE LIGHTHOUSE\n\"Enlightening Ideas for Public Policy...\"\nVol. 3, Issue 45\nNovember 19, 2001\n\nWelcome to The Lighthouse, the e-mail newsletter of The Independent \nInstitute, the non-politicized, public policy research organization \n<http://www.independent.org>. We provide you with updates of the \nInstitute's current research publications, events and media programs.\n\nDo you know someone who would enjoy THE LIGHTHOUSE? Please forward \nthis message to a friend. If they like it, they can add themselves to \nthe list at http://www.independent.org/tii/lighthouse/Lighthouse.html.\n\n-------------------------------------------------------------\n\nIN THIS WEEK'S ISSUE:\n1. Revised Draft No Better Than Original\n2. The Second Amendment, the Courts and the Professoriate\n3. Why \"Smart Growth\" Isn't\n\n-------------------------------------------------------------\n\nREVISED DRAFT NO BETTER THAN ORIGINAL\n\nAlthough President Bush said he would resist efforts to reinstate \nconscription, its growing popularity among the pundit class is likely \nto make the draft an important topic in upcoming public debate. But \ndon't expect this discussion to exactly parallel the debate that led \nto its termination in 1973.\n\nToday's \"war against terrorism\" is creating a dynamic that is \nredrawing the domestic political landscape, creating new coalitions \npotentially strong enough to have the draft reinstated.\n\nMost of the nation's political groups have factions that would like \nto see some type of involuntary servitude, be they anti-capitalist \n\"progressives\" who want to see the best of the nation's youth \nderailed from the career fast track, nationalistic \"conservatives\" \nwho want to mandate \"patriotism\" and reinvigorate a strong sense of \nnation-consciousness, or Demopublican \"moderates,\" such as Secretary \nof State Colin Powell, who want youth to make \"voluntarism\" a high \npriority.\n\nBut just as the war on terrorism is \"like no other war\" (Bush), so \nthe next draft is not your father's draft. Charles Moskos and Paul \nGlastris, writing in the WASHINGTON POST, make clear that the new \ndraft will be packaged not as a cheap, quick way to enlarge the \nmilitary, but as a new form of government-assisted public expression \nof the conscripts' values, i.e., a form of choice! Draftees will thus \nhave their pick among, for example, the armed services, homeland \ndefense jobs, such as airport security, and civilian national-service \nprograms, such as AmeriCorps. As Independent Institute senior fellow \nRobert Higgs says, \"some choice.\"\n\n\"Moskos and Glastris's proposal raises several important questions,\" \nwrites Higgs, \"none of which they see fit to consider. Perhaps in a \nfollow-up article they will tell us: Whatever happened to the idea \nthat every person, even a young man, has inalienable rights to life, \nliberty, and the pursuit of happiness? Whatever happened to the idea \nthat a just government is instituted to secure these rights, not to \ncrush them underfoot upon the earliest pretext? What exactly do we \ngain if we can defend ourselves only by destroying the very heart and \nsoul of what it is about this country that deserves defending?\"\n\nSee \"Will the Draft Rise from the Dead?\" by Robert Higgs \n(LewRockwell.com, 11/15/01), at\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-1.html.\n\nFor detailed background on the growth of government and the draft, \nsee \"War and Leviathan in Twentieth-Century America: Conscription as \nthe Keystone,\" by Robert Higgs, at\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-2.html.\n\n-------------------------------------------------------------\n\nTHE SECOND AMENDMENT, THE COURTS AND THE PROFESSORIATE\n\nThe most important firearm case in years, United States v. Emerson, \nwas a solid victory for the rights of gun owners. One of the \nstrengths of the decision, rendered earlier this year by the U.S. \nCourt of Appeals for the Fifth Circuit, was its citation of the vast \nbody of scholarship that supports the individual rights \ninterpretation of the Second Amendment, as well as numerous \nstatements made by America's founders showing that \"the right of the \npeople to keep and bear arms\" was intended to protect an individual \nright. This alone will help ensure that the correct interpretation of \nthe Second Amendment will spread, as jurists, attorneys, and law \nstudents study the decision's citations for years to come.\n\nCritics of the individual-rights interpretation, however, have not \nrelented. But neither has Independent Institute research fellow and \nSecond Amendment attorney Stephen Halbrook, author of the classic \nbook, THAT EVERY MAN BE ARMED: The Evolution of a Constitutional \nRight, as he made clear in two recent replies to prominent law school \nprofessors.\n\nAccording to Prof. Michael Dorf of Columbia University Law School, \ndespite the Emerson decision the individual-rights interpretation of \nthe Second Amendment is as much a \"fraud on the American public\" as \nwhen ex-Chief Justice Warren Burger passed that judgement nearly \ntwelve years ago. Halbrook, however, explains that the Emerson \"is \nthe first ever federal appellate opinion to contribute an adequate \ntextual analysis of the Second Amendment.\" Thus, the decision \nobserved that \"throughout the Constitution, the 'people' have \n'rights' and 'powers,' but federal and state governments only have \n'powers' or 'authority,' never 'rights.'\"\n\nFurther, says Dorf, the Second Amendment protects only an armed \nmilitia, as indicated by the preamble, \"A well regulated militia, \nbeing necessary to the security of a free state....\" Responds \nHalbrook: \"But as Emerson explains, this preamble announces the \nobjective of securing a free state by a militia, which in turn is \nencouraged by and drawn from the people who exercise the right to \nkeep and bear arms.\" Similarly, Halbrook easily dispatches numerous \nother distortions by Dorf.\n\nUnlike Dorf, constitutional scholars Amar Akhil (Yale) and Vikram \nAmar (UC Hastings) have a generally correct assessment about the \nEmerson decision but are guilty of committing a few historical \noversights. For example, the Amars state that \"the Emerson court \nfound only one clear nonmilitary use of the phrase before 1798,\" but \nthey overlook numerous statements by Jefferson, Madison and Adams \nexplicitly advocating the protection of a right to keep and bear \nfirearms for self-defense.\n\nSee:\n\n\"Reports of the Death of the Second Amendment Have Been Greatly \nExaggerated: The Emerson Decision,\" by Stephen P. Halbrook, at \nhttp://www.independent.org/tii/lighthouse/LHLink3-46-3.html.\n\n\"Emerson's Second Amendment,\" Stephen P. Halbrook, at \nhttp://www.independent.org/tii/lighthouse/LHLink3-46-4.html.\n\nFor a summary of the new edition of Stephen P. Halbrook's classic, \nTHAT EVERY MAN BE ARMED: The Evolution of a Constitutional Right, see \nhttp://www.independent.org/tii/lighthouse/LHLink3-46-5.html.\n\n-------------------------------------------------------------\n\nWHY \"SMART GROWTH\" ISN'T\n\nHigh-density living, characterized by \"transit villages\" close to \npublic transportation, will reduce air pollution, save commuters from \nthe aggravation of traffic congestion and contribute to an improved \nquality of life in our communities, according to proponents of the \nfaddish \"smart growth\" movement.\n\nAre these claims true? Would we be better off moving back to the \ncities and junking our cars?\n\nAccording to urban economists Daniel Klein and Randal O'Toole -- who \ndiscussed these questions in our Oct. 3rd Independent Policy Forum, \n\"Smarter Urban Growth: Markets or Bureaucracy?\" --  the \"smart \ngrowth\" movement is \"smart\" in name only, since many of its policies \nwork against their intended goals.\n\nSmart growth advocates uphold public rail systems in European cities \nas models but ignore the fact that with few exceptions American \ncities lack the population density needed to make rail systems \ncost-effective. And with good reason: automobiles are more flexible, \nfaster, affordable, safe and comfortable. And as cars have improved \nin quality, the U.S. urban public transit market has been shrinking. \nHence, cities that build rail systems display little economic sense \nbut plenty of what Klein called \"infrastructure envy.\"\n\nO'Toole pointed out that the costs of smart growth are significantly \nlarger than its proponents recognize. Drawing largely upon the \nexperience of Portland, Oregon, O'Toole showed how smart-growth \npolicies have led to escalating housing prices, tied up the 98% of \nthe state that remains rural open space, and contributed to bad \ntraffic congestion and air pollution. \n\nFor the transcript of \"Smarter Urban Growth: Markets or Bureaucracy?\" \nwith Dan Klein and Randal O'Toole, see\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-6.html.\n\nAlso see:\n\n\"Curb Rights: Eliciting Competition and Entrepreneurship in Urban \nTransit\" by Daniel Klein, Adrian Moore, and Binyamin Reja (THE \nINDEPENDENT REVIEW, Summer 1997), at\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-7.html.\n\n\"Is Urban Planning \"Creeping Socialism\"? by Randal O'Toole (THE \nINDEPENDENT REVIEW, Spring 2000), at\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-8.html.\n\n\"The Lone Mountain Compact: Principles for Preserving Freedom and \nLivability in America's Cities and Suburbs\" at\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-9.html.\n\n-------------------------------------------------------------\n\nTHE LIGHTHOUSE, edited by Carl P. Close, is made possible by the \ngenerous contributions of supporters of The Independent Institute. If \nyou enjoy THE LIGHTHOUSE, please consider making a donation to The \nIndependent Institute. For details on the Independent Associate \nMembership program, see \nhttp://www.independent.org/tii/lighthouse/LHLink3-46-10.html\nor contact Mr. Rod Martin by phone at 510-632-1366 x114, fax to \n510-568-6040, email to <RMartin@independent.org>, or snail mail to \nThe Independent Institute, 100 Swan Way, Oakland, CA 94621-1428. All \ncontributions are tax-deductible.  Thank you!\n\n-------------------------------------------------------------\n\nFor previous issues of THE LIGHTHOUSE, see\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-11.html.\n\n-------------------------------------------------------------\n\nFor information on books and other publications from The Independent \nInstitute, see\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-12.html.\n\n-------------------------------------------------------------\n\nFor information on The Independent Institute's upcoming Independent \nPolicy Forums, see\nhttp://www.independent.org/tii/lighthouse/LHLink3-46-13.html.\n\n-------------------------------------------------------------\n\nTo subscribe (or unsubscribe) to The Lighthouse, please go to \nhttp://www.independent.org/subscribe.html, choose \"subscribe\" (or \n\"unsubscribe\"), enter your e-mail address and select \"Go.\"\n\n-------------------------------------------------------------\n\nTHE LIGHTHOUSE\nISSN 1526-173X\nCopyright ???? 2001 The Independent Institute\n100 Swan Way\nOakland, CA 94621-1428\n(510) 632-1366 phone\n(510) 568-6040 fax"
    ## [3] "Received: from NAPDX-MSMBX01V.corp.enron.com ([172.17.176.252]) by NAHOU-MSMBX07V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Mon, 29 Oct 2001 12:17:08 -0600\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: FW: FYI\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\nDate: Mon, 29 Oct 2001 10:17:07 -0800\nMessage-ID: <72B998DC79EB024085C9395CCEC2BFEE29C97D@NAPDX-MSMBX01V.corp.enron.com>\nX-MS-Has-Attach: \nX-MS-TNEF-Correlator: <72B998DC79EB024085C9395CCEC2BFEE29C97D@NAPDX-MSMBX01V.corp.enron.com>\nThread-Topic: FYI\nThread-Index: AcFeaps1Dk5XqomCRxaeUUJs1EEcLAACP+OhAIyLmMA=\nFrom: \"Kaufman, Paul\" <Paul.Kaufman@ENRON.com>\nTo: \"Steffes, James D.\" <James.D.Steffes@ENRON.com>\nReturn-Path: Paul.Kaufman@ENRON.com\n\nThe response I received when I suggested we would try and get a meeting with APS (ala your e-mails to Leslie and her e-mails back).\n\n-----Original Message-----\nFrom: Thomas, Jake \nSent: Friday, October 26, 2001 4:12 PM\nTo: Kaufman, Paul\nSubject: Re: FYI\n\n\nPaul\n\nWe just recently met with APS.  You may want to check with Chris Calger !\n--------------------------\nSent from my BlackBerry Wireless Handheld (www.BlackBerry.net)"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
    ## [4] "Recieved: from nahou-mscnx06p.corp.enron.com ([192.168.110.237]) by NAHOU-MSAPP01S.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Fri, 26 Oct 2001 12:38:38 -0500\nReceived: from corp.enron.com ([192.168.110.226]) by nahou-mscnx06p.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Fri, 26 Oct 2001 12:38:36 -0500\nReceived: from mailman.enron.com (unverified) by corp.enron.com\n (Content Technologies SMTPRS 4.2.1) with ESMTP id <T56d56d9452c0a86ee284c@corp.enron.com>;\n Fri, 26 Oct 2001 12:38:35 -0500\nReceived: from dserv1.ect.enron.com (dserv1.ect.enron.com [172.16.1.37])\n\tby mailman.enron.com (8.11.4/8.11.4/corp-1.06) with ESMTP id f9QHcZV14800;\n\tFri, 26 Oct 2001 12:38:35 -0500 (CDT)\nReceived: from anonymous (ecthou-bps3.corp.enron.com [172.16.4.77])\n\tby dserv1.ect.enron.com (8.8.8/8.8.8) with SMTP id MAA07052;\n\tFri, 26 Oct 2001 12:38:35 -0500 (CDT)\nDate: Fri, 26 Oct 2001 12:38:35 -0500 (CDT)\nMessage-Id: <200110261738.MAA07052@dserv1.ect.enron.com>\nFrom: Schedule Crawler<pete.davis@enron.com>\nTo: pete.davis@enron.com\nCC: bert.meyers@enron.com, bill.williams.III@enron.com, Craig.Dean@enron.com,\n   Eric.Linder@enron.com, Geir.Solberg@enron.com, Kate.Symes@enron.com,\n   leaf.harasin@enron.com, mark.guzman@enron.com, pete.davis@enron.com,\n   ryan.slinger@enron.com, smerris@enron.com\nSubject: Start Date: 10/26/01; HourAhead hour: 13;  <CODESITE>\nMime-Version: 1.0\nContent-Type: text/plain; charset=\"us-ascii\"\nReturn-Path: pete.davis@enron.com\n\n\n\nStart Date: 10/26/01; HourAhead hour: 13;  No ancillary schedules awarded.  No variances detected. \n\n    LOG MESSAGES:\n\nPARSING FILE -->> O:\\Portland\\WestDesk\\California Scheduling\\ISO Final Schedules\\2001102613.txt\n\nError retrieving HourAhead price data - process continuing...\n---- Energy Import/Export Schedule ----\n*** Final schedule not found for preferred schedule.\n     Details:\n\n  TRANS_TYPE: FINAL\n  SC_ID: ECTRT\n  MKT_TYPE: 2\n  TRANS_DATE: 10/26/01\n  TIE_POINT: PVERDE_5_DEVERS\n  INTERCHG_ID: CISO_EPMI_APS\n  ENGY_TYPE: NFRM"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    ## [5] "Received: from NAHOU-MSMBX03V.corp.enron.com ([192.168.110.40]) by NAHOU-MSMBX05V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Wed, 29 Aug 2001 08:54:31 -0500\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\nContent-Class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: RE: Entouch\nDate: Wed, 29 Aug 2001 08:54:30 -0500\nMessage-ID: <8B8F71DE55D07C4B94CEA9EC69A25728457960@NAHOU-MSMBX03V.corp.enron.com>\nX-MS-Has-Attach: \nX-MS-TNEF-Correlator: <8B8F71DE55D07C4B94CEA9EC69A25728457960@NAHOU-MSMBX03V.corp.enron.com>\nThread-Topic: Entouch\nThread-Index: AcEwi2xkR0rZvm8IRK2XOwzflh6hPAABpQDA\nFrom: \"Hochschild, Lenny\" <Lenny.Hochschild@ENRON.com>\nTo: \"Taylor, Michael E\" <Michael.E.Taylor@ENRON.com>,\n\t\"Wharton, Marc\" <marc.wharton@ENRON.com>\nReturn-Path: Lenny.Hochschild@ENRON.com\n\n\n\n -----Original Message-----\nFrom: \tTaylor, Michael E  \nSent:\tWednesday, August 29, 2001 8:07 AM\nTo:\tWharton, Marc; Hochschild, Lenny\nSubject:\tEntouch\n\nWhat do you think?  Any changes?  I need to send this out this morning!\n\n\n<<\nCoal and Emissions Trading\n\nThe first Enron Online synfuel trade occurred this past week, establishing EOL as the only online marketplace for synfuel.  The purpose of  bringing synfuel on EOL is to provide market transparency between the coal/synfuel spread.  \n\nThe coal cash book, which began trading only two months ago, has traded over 2 million spot tons.  The fundamental purpose of this book is to capture short term market discrepancies, while also adding liquidity to the spot market to further long term trading and marketing while reducing execution risk.\n\n>>\n\nMike"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
    ## [6] "Received: from NAHOU-MSMBX01V ([192.168.110.38]) by NAHOU-MSMBX05V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.1600);\n\t Wed, 8 Aug 2001 15:43:47 -0500\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: New CDWR Revenue Requirement\nDate: Wed, 8 Aug 2001 15:43:46 -0500\nMessage-ID: <C4D8F88AD9AE8D4A905C26649E98DC5D06FA4D@NAHOU-MSMBX01V.corp.enron.com>\nX-MS-Has-Attach: yes\nX-MS-TNEF-Correlator: <C4D8F88AD9AE8D4A905C26649E98DC5D06FA4D@NAHOU-MSMBX01V.corp.enron.com>\nThread-Topic: New CDWR Revenue Requirement\nThread-Index: AcEgSaahos79oJagRhKiFiMgTeF3qw==\nFrom: \"Tribolet, Michael\" <Michael.Tribolet@ENRON.com>\nTo: \"Shapiro, Richard\" <Richard.Shapiro@ENRON.com>,\n\t\"Steffes, James D.\" <James.D.Steffes@ENRON.com>,\n\t\"Kingerski, Harry\" <Harry.Kingerski@ENRON.com>,\n\t\"Dasovich, Jeff\" <Jeff.Dasovich@ENRON.com>,\n\t\"Mara, Susan\" <Susan.J.Mara@ENRON.com>\nReturn-Path: Michael.Tribolet@ENRON.com\n\nI have attached a comparison of the revised CDWR Revenue Requirement, along with a comparison with the July 22nd figures.\n \n* The total DWR dollars decrease $471.5 million over 2001 and 2002, centered in the periods 3Q 2001 and onward.  The \"past problem\" actually increases by $1.9 billion (1Q & 2Q 2001).\n* PG&E has their share increased $730.1 million over 2002 and 2002, centered in 1Q and 2Q 2001.\n* Edison ends up with a significant decrease of $1.199 billion in 2001 and 2002.\n \n \nRegards,\n \n \nMichael"

``` r
contents[1]
```

    ## [1] "Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Tue, 20 Nov 2001 09:03:18 -0600\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: FW: Govt Affairs Org Chart\nDate: Tue, 20 Nov 2001 09:03:18 -0600\nMessage-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nX-MS-Has-Attach: yes\nX-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nThread-Topic: Govt Affairs Org Chart\nThread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g\nFrom: \"Dietrich, Janet\" <Janet.Dietrich@ENRON.com>\nTo: \"Kitchen, Louise\" <Louise.Kitchen@ENRON.com>\nReturn-Path: Janet.Dietrich@ENRON.com\n\n\n\n -----Original Message-----\nFrom: \tSteffes, James D.  \nSent:\tMonday, November 19, 2001 6:12 PM\nTo:\tDietrich, Janet\nCc:\tShapiro, Richard\nSubject:\tGovt Affairs Org Chart\n\nJanet --\n\nHere is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.\n\nTotal headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    \n\nPlease let me know if you have any questions.\n\nJim"

``` r
cat(contents[1], "\n")
```

    ## Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);
    ##   Tue, 20 Nov 2001 09:03:18 -0600
    ## X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
    ## content-class: urn:content-classes:message
    ## MIME-Version: 1.0
    ## Content-Type: text/plain;
    ## Content-Transfer-Encoding: binary
    ## Subject: FW: Govt Affairs Org Chart
    ## Date: Tue, 20 Nov 2001 09:03:18 -0600
    ## Message-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>
    ## X-MS-Has-Attach: yes
    ## X-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>
    ## Thread-Topic: Govt Affairs Org Chart
    ## Thread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g
    ## From: "Dietrich, Janet" <Janet.Dietrich@ENRON.com>
    ## To: "Kitchen, Louise" <Louise.Kitchen@ENRON.com>
    ## Return-Path: Janet.Dietrich@ENRON.com
    ## 
    ## 
    ## 
    ##  -----Original Message-----
    ## From:    Steffes, James D.  
    ## Sent:    Monday, November 19, 2001 6:12 PM
    ## To:  Dietrich, Janet
    ## Cc:  Shapiro, Richard
    ## Subject: Govt Affairs Org Chart
    ## 
    ## Janet --
    ## 
    ## Here is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.
    ## 
    ## Total headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    
    ## 
    ## Please let me know if you have any questions.
    ## 
    ## Jim

#### Structure of an email

-   Headers give metadata
-   Blank line
-   Body of email
    Other major complication is attachments and alternative content, but we'll ignore those for class

#### Tasks

-   Split into header and contents
-   Split header into fields
-   Make variable that might be interesting to explore

### String Basics

Special characters

``` r
a <- "\""
b <- "\\"
c <- "a\nb\nc"
a # displays the representation
```

    ## [1] "\""

``` r
cat(a, "\n") # displays the actual string
```

    ## "

``` r
b
```

    ## [1] "\\"

``` r
cat(b, "\n") # "\n" tells R to start a new line
```

    ## \

``` r
c
```

    ## [1] "a\nb\nc"

``` r
cat(c, "\n")
```

    ## a
    ## b
    ## c

``` r
contents[1]
```

    ## [1] "Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Tue, 20 Nov 2001 09:03:18 -0600\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: FW: Govt Affairs Org Chart\nDate: Tue, 20 Nov 2001 09:03:18 -0600\nMessage-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nX-MS-Has-Attach: yes\nX-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nThread-Topic: Govt Affairs Org Chart\nThread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g\nFrom: \"Dietrich, Janet\" <Janet.Dietrich@ENRON.com>\nTo: \"Kitchen, Louise\" <Louise.Kitchen@ENRON.com>\nReturn-Path: Janet.Dietrich@ENRON.com\n\n\n\n -----Original Message-----\nFrom: \tSteffes, James D.  \nSent:\tMonday, November 19, 2001 6:12 PM\nTo:\tDietrich, Janet\nCc:\tShapiro, Richard\nSubject:\tGovt Affairs Org Chart\n\nJanet --\n\nHere is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.\n\nTotal headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    \n\nPlease let me know if you have any questions.\n\nJim"

Does exactly the same thing (unless you're inside a function)

``` r
print(contents[1])
```

    ## [1] "Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Tue, 20 Nov 2001 09:03:18 -0600\nX-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0\ncontent-class: urn:content-classes:message\nMIME-Version: 1.0\nContent-Type: text/plain;\nContent-Transfer-Encoding: binary\nSubject: FW: Govt Affairs Org Chart\nDate: Tue, 20 Nov 2001 09:03:18 -0600\nMessage-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nX-MS-Has-Attach: yes\nX-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>\nThread-Topic: Govt Affairs Org Chart\nThread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g\nFrom: \"Dietrich, Janet\" <Janet.Dietrich@ENRON.com>\nTo: \"Kitchen, Louise\" <Louise.Kitchen@ENRON.com>\nReturn-Path: Janet.Dietrich@ENRON.com\n\n\n\n -----Original Message-----\nFrom: \tSteffes, James D.  \nSent:\tMonday, November 19, 2001 6:12 PM\nTo:\tDietrich, Janet\nCc:\tShapiro, Richard\nSubject:\tGovt Affairs Org Chart\n\nJanet --\n\nHere is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.\n\nTotal headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    \n\nPlease let me know if you have any questions.\n\nJim"

``` r
cat(contents[1], "\n")
```

    ## Received: from NAHOU-MSMBX05V.corp.enron.com ([172.24.192.109]) by NAHOU-MSMBX03V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);
    ##   Tue, 20 Nov 2001 09:03:18 -0600
    ## X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
    ## content-class: urn:content-classes:message
    ## MIME-Version: 1.0
    ## Content-Type: text/plain;
    ## Content-Transfer-Encoding: binary
    ## Subject: FW: Govt Affairs Org Chart
    ## Date: Tue, 20 Nov 2001 09:03:18 -0600
    ## Message-ID: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>
    ## X-MS-Has-Attach: yes
    ## X-MS-TNEF-Correlator: <61254F3582F4D34C9633912989710C29180FDE@NAHOU-MSMBX05V.corp.enron.com>
    ## Thread-Topic: Govt Affairs Org Chart
    ## Thread-Index: AcFxV/ZEcUOh+9NxThS58gVO5uQKfgAfID9g
    ## From: "Dietrich, Janet" <Janet.Dietrich@ENRON.com>
    ## To: "Kitchen, Louise" <Louise.Kitchen@ENRON.com>
    ## Return-Path: Janet.Dietrich@ENRON.com
    ## 
    ## 
    ## 
    ##  -----Original Message-----
    ## From:    Steffes, James D.  
    ## Sent:    Monday, November 19, 2001 6:12 PM
    ## To:  Dietrich, Janet
    ## Cc:  Shapiro, Richard
    ## Subject: Govt Affairs Org Chart
    ## 
    ## Janet --
    ## 
    ## Here is the org chart that captures our discussions.  I think that this org and the # of people is the lowest level that can even try to meet the combined needs of ENA and EES.
    ## 
    ## Total headcount = 21.  The personnel cost = $6.4 MM (total for ENA and EES).    
    ## 
    ## Please let me know if you have any questions.
    ## 
    ## Jim

#### Special characters

-   Use `\` to "escape" special characters
-   `\"` = `"`
-   `\n` = new line
-   `\\` = `\`
-   `\t` = tab
-   ?Quotes for more

### Exercise

Create a string for each of the following strings: :-
(^\_^") @\_'-' / Create a multiline string. Compare the output from print() and cat()

``` r
a <- ":-\\"
print(a) 
```

    ## [1] ":-\\"

``` r
cat(a, "\n")
```

    ## :-\

``` r
b <- "(^_^\")"
print(b)
```

    ## [1] "(^_^\")"

``` r
cat(b, "\n")
```

    ## (^_^")

``` r
c <- "@_'-'"
print(c)
```

    ## [1] "@_'-'"

``` r
cat(c, "\n")
```

    ## @_'-'

``` r
d <- "\\m/"
print(d)
```

    ## [1] "\\m/"

``` r
cat(d, "\n")
```

    ## \m/

``` r
e <- "Create\na\nmultiline\nstring."
print(e)
```

    ## [1] "Create\na\nmultiline\nstring."

``` r
cat(e, "\n")
```

    ## Create
    ## a
    ## multiline
    ## string.

Stringr
-------

``` r
# install.packages("stringr")
```

``` r
library(stringr)

help(package = "stringr")
```

The last call lists all functions in a package all functions in stringr start with str\_

``` r
apropos("str_")
```

    ##  [1] "str_c"           "str_conv"        "str_count"      
    ##  [4] "str_detect"      "str_dup"         "str_extract"    
    ##  [7] "str_extract_all" "str_interp"      "str_join"       
    ## [10] "str_length"      "str_locate"      "str_locate_all" 
    ## [13] "str_match"       "str_match_all"   "str_order"      
    ## [16] "str_pad"         "str_replace"     "str_replace_all"
    ## [19] "str_replace_na"  "str_sort"        "str_split"      
    ## [22] "str_split_fixed" "str_sub"         "str_sub<-"      
    ## [25] "str_subset"      "str_to_lower"    "str_to_title"   
    ## [28] "str_to_upper"    "str_trim"        "str_trunc"      
    ## [31] "str_view"        "str_view_all"    "str_which"      
    ## [34] "str_wrap"

The last call lists all functions with names containing specified characters

### Header vs. Content

Need to split the string into two pieces, based on the the location of double line break: str\_locate(string, pattern) Need two substrings, one to the right and one to the left: str\_sub(string, start, end)

#### Examples

``` r
str_locate("great", "a") # "a" starts and ends at position shown
```

    ##      start end
    ## [1,]     4   4

``` r
str_locate("fantastic", "a") # first instance
```

    ##      start end
    ## [1,]     2   2

``` r
str_locate("super", "a")
```

    ##      start end
    ## [1,]    NA  NA

``` r
superlatives <- c("great", "fantastic", "super")
res <- str_locate(superlatives, "a")
str(res) # matrix
```

    ##  int [1:3, 1:2] 4 2 NA 4 2 NA
    ##  - attr(*, "dimnames")=List of 2
    ##   ..$ : NULL
    ##   ..$ : chr [1:2] "start" "end"

``` r
res
```

    ##      start end
    ## [1,]     4   4
    ## [2,]     2   2
    ## [3,]    NA  NA

``` r
str(str_locate_all(superlatives, "a")) # list
```

    ## List of 3
    ##  $ : int [1, 1:2] 4 4
    ##   ..- attr(*, "dimnames")=List of 2
    ##   .. ..$ : NULL
    ##   .. ..$ : chr [1:2] "start" "end"
    ##  $ : int [1:2, 1:2] 2 5 2 5
    ##   ..- attr(*, "dimnames")=List of 2
    ##   .. ..$ : NULL
    ##   .. ..$ : chr [1:2] "start" "end"
    ##  $ : int[0 , 1:2] 
    ##   ..- attr(*, "dimnames")=List of 2
    ##   .. ..$ : NULL
    ##   .. ..$ : chr [1:2] "start" "end"

``` r
str_sub("testing", 1, 3)
```

    ## [1] "tes"

``` r
str_sub("testing", start = 4) # by default goes to end
```

    ## [1] "ting"

``` r
str_sub("testing", end = 4) # by default starts at 1
```

    ## [1] "test"

``` r
input <- c("abc", "defg")
str_sub(input, c(2, 3)) # item 1 - start at 2, item 2 - start at 3
```

    ## [1] "bc" "fg"

### Exercise

Use str\_locate() to identify the location of the blank line. (Hint: a blank line is a newline immediately followed by another newline).
Split the emails into header and content with str\_sub() Make sure to check your results.

``` r
breaks <- str_locate(contents, "\n\n")
kable(head(breaks))
```

|  start|   end|
|------:|-----:|
|    842|   843|
|   1363|  1364|
|    806|   807|
|   1471|  1472|
|    862|   863|
|   1023|  1024|

Extract headers and bodies

``` r
header <- str_sub(contents, end = breaks[, 1])
body <- str_sub(contents, start = breaks[, 2])
```

Is everything ok with breaks? \#\#\# Headers Each header starts at the beginning of a new line Each header is composed of a name and contents, separated by a colon

``` r
h <- header[2]
```

Does this work?

``` r
str_split(h, "\n")[[1]]
```

    ##  [1] "Recieved: from nahou-mscnx06p.corp.enron.com ([192.168.110.237]) by NAHOU-MSMBX01V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);"
    ##  [2] "\t Mon, 19 Nov 2001 23:27:31 -0600"                                                                                                       
    ##  [3] "Received: from corp.enron.com ([192.168.110.224]) by nahou-mscnx06p.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);"               
    ##  [4] "\t Mon, 19 Nov 2001 23:27:31 -0600"                                                                                                       
    ##  [5] "Received: from mailman.enron.com (unverified) by corp.enron.com"                                                                         
    ##  [6] " (Content Technologies SMTPRS 4.2.1) with ESMTP id <T5753582523c0a86ee057c@corp.enron.com>;"                                             
    ##  [7] " Mon, 19 Nov 2001 23:27:20 -0600"                                                                                                        
    ##  [8] "Received: from independent.org (dnai-216-15-109-150.cust.dnai.com [216.15.109.150])"                                                     
    ##  [9] "\tby mailman.enron.com (8.11.4/8.11.4/corp-1.06) with SMTP id fAK5REV10291;"                                                              
    ## [10] "\tMon, 19 Nov 2001 23:27:17 -0600 (CST)"                                                                                                  
    ## [11] "Received: from pop.independent.org by independent.org with POP3; Mon, 19"                                                                
    ## [12] " Nov 2001 18:11:50 -0800"                                                                                                                
    ## [13] "Delivered-To: swan001-Lighthouse@independent.org"                                                                                        
    ## [14] "Mime-Version: 1.0"                                                                                                                       
    ## [15] "X-Sender: swan001.mailadmin@pop.independent.org"                                                                                         
    ## [16] "Message-Id: <a05100300b81f6c349681@[216.15.109.150]>"                                                                                    
    ## [17] "Date: Mon, 19 Nov 2001 18:11:01 -0800"                                                                                                   
    ## [18] "To: \"Lighthouse\" <Lighthouse@independent.org>"                                                                                         
    ## [19] "From: \"David J. Theroux\" <DJTheroux@independent.org>"                                                                                  
    ## [20] "Subject: THE LIGHTHOUSE: November 19, 2001"                                                                                              
    ## [21] "Content-Type: text/plain; charset=\"iso-8859-1\" ; format=\"flowed\""                                                                    
    ## [22] "Content-Transfer-Encoding: quoted-printable"                                                                                             
    ## [23] "Sender: <Lighthouse@independent.org>"                                                                                                    
    ## [24] "Precedence: Bulk"                                                                                                                        
    ## [25] "Return-Path: Lighthouse@independent.org"                                                                                                 
    ## [26] ""

Fix the issue

``` r
lines <- str_split(h, "\n")
```

because str\_split returns a list with one element for each input string

``` r
lines <- lines[[1]]
continued <- str_sub(lines, 1, 1) %in% c(" ", "\t")
```

This is a useful trick!

``` r
groups <- cumsum(!continued)
fields <- rep(NA, max(groups))
for (i in seq_along(fields)) {
  fields[i] <- str_c(lines[groups == i], collapse = "\n")
}
```

Or

``` r
tapply(lines, groups, str_c, collapse = "\n")
```

    ##                                                                                                                                                                                                         1 
    ##                             "Recieved: from nahou-mscnx06p.corp.enron.com ([192.168.110.237]) by NAHOU-MSMBX01V.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Mon, 19 Nov 2001 23:27:31 -0600" 
    ##                                                                                                                                                                                                         2 
    ##                                            "Received: from corp.enron.com ([192.168.110.224]) by nahou-mscnx06p.corp.enron.com with Microsoft SMTPSVC(5.0.2195.2966);\n\t Mon, 19 Nov 2001 23:27:31 -0600" 
    ##                                                                                                                                                                                                         3 
    ##          "Received: from mailman.enron.com (unverified) by corp.enron.com\n (Content Technologies SMTPRS 4.2.1) with ESMTP id <T5753582523c0a86ee057c@corp.enron.com>;\n Mon, 19 Nov 2001 23:27:20 -0600" 
    ##                                                                                                                                                                                                         4 
    ## "Received: from independent.org (dnai-216-15-109-150.cust.dnai.com [216.15.109.150])\n\tby mailman.enron.com (8.11.4/8.11.4/corp-1.06) with SMTP id fAK5REV10291;\n\tMon, 19 Nov 2001 23:27:17 -0600 (CST)" 
    ##                                                                                                                                                                                                         5 
    ##                                                                                                      "Received: from pop.independent.org by independent.org with POP3; Mon, 19\n Nov 2001 18:11:50 -0800" 
    ##                                                                                                                                                                                                         6 
    ##                                                                                                                                                        "Delivered-To: swan001-Lighthouse@independent.org" 
    ##                                                                                                                                                                                                         7 
    ##                                                                                                                                                                                       "Mime-Version: 1.0" 
    ##                                                                                                                                                                                                         8 
    ##                                                                                                                                                         "X-Sender: swan001.mailadmin@pop.independent.org" 
    ##                                                                                                                                                                                                         9 
    ##                                                                                                                                                    "Message-Id: <a05100300b81f6c349681@[216.15.109.150]>" 
    ##                                                                                                                                                                                                        10 
    ##                                                                                                                                                                   "Date: Mon, 19 Nov 2001 18:11:01 -0800" 
    ##                                                                                                                                                                                                        11 
    ##                                                                                                                                                         "To: \"Lighthouse\" <Lighthouse@independent.org>" 
    ##                                                                                                                                                                                                        12 
    ##                                                                                                                                                  "From: \"David J. Theroux\" <DJTheroux@independent.org>" 
    ##                                                                                                                                                                                                        13 
    ##                                                                                                                                                              "Subject: THE LIGHTHOUSE: November 19, 2001" 
    ##                                                                                                                                                                                                        14 
    ##                                                                                                                                    "Content-Type: text/plain; charset=\"iso-8859-1\" ; format=\"flowed\"" 
    ##                                                                                                                                                                                                        15 
    ##                                                                                                                                                             "Content-Transfer-Encoding: quoted-printable" 
    ##                                                                                                                                                                                                        16 
    ##                                                                                                                                                                    "Sender: <Lighthouse@independent.org>" 
    ##                                                                                                                                                                                                        17 
    ##                                                                                                                                                                                        "Precedence: Bulk" 
    ##                                                                                                                                                                                                        18 
    ##                                                                                                                                                                 "Return-Path: Lighthouse@independent.org" 
    ##                                                                                                                                                                                                        19 
    ##                                                                                                                                                                                                        ""

### Exercise

Write a small function that given a single header field splits it into name and contents. Do you want to use str\_split(), or str\_locate() & str\_sub()? Remember to get the algorithm working before you write the function

``` r
test1 <- "Sender: <Lighthouse@independent.org>"
test2 <- "Subject: Alice: Where is my coffee?"

f1 <- function(input) {
  str_split(input, ": ")[[1]]
}
f2 <- function(input) {
  colon <- str_locate(input, ": ")
  c(
    str_sub(input, end = colon[, 1] - 1),
    str_sub(input, start = colon[, 2] + 1)
  )
}
f3 <- function(input) {
  str_split_fixed(input, ": ", 2)[1, ]
}
```

### Next Steps

We split the content into header and body. And split up the header into fields. Both of these tasks used fixed strings. What if the pattern we need to match is more complicated?

See next lecture.
