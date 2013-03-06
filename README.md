# BobCat Embeddable Search Snippets (bess)

[![Build Status](https://travis-ci.org/NYULibraries/bess.png?branch=master)](https://travis-ci.org/NYULibraries/bess)

bess is a library that allows for the creation of embeddable search boxes for the BobCat application (NYU Libraries' implementation of ExLibris's Primo catalog discovery tool). It also provides an interface for customizing the embeds (see BobcatEmbedGenerate.php) and generates the code to embed in different formats, e.g. SSI, JavaScript, HTML.

The concept a code structure for this was heavily influenced by [Xerxes](https://code.google.com/p/xerxes-portal/).

## Dependencies

* PHP >= 5.2
* mod_rewrite 

This application was written specifically to implement the BobCat application but can be generalized as an embed script for other discovery interfaces.

[Working example](http://web1.library.nyu.edu/bobcat/)

## TO DO

* More testing coverage
* Generalize to any discovery service where you can post or get to a form
* If possible, pull config for searching out of Primo
* Has structure in place for internationalization, but doesn't implement
* Settings XML file needs full schema to be documented