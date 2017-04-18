# LogDNA Backend Engineering Challenge (parser)
=====================================
By Kamran 

----
The Problem
----
In order for search to run, we need to translate plain text queries into some form of JSON format that can then be consumed by services to perform search or filtering down the line. I have to write a REST API service that takes as input a plain text string and as output generates a JSON that describes the following search rules.

Search rules:
- terms are implicitly AND'd together unless quoted
- terms are implicitly an exact match
- multiple search terms can be nested using ()'s
- negation can be done using ! in front of search term
- OR'ing search terms can be done by explicitly using "OR" keyword
- AND'ing search terms can optionally be done by explicitly using "AND" keyword
- using '>', '>=', '<', '=<' denotes a non exact match on the term following respective symbol
- using '=' denotes an exact match on the term following respective symbol
- len(#) will allow us to match length of JSON data instead of actual value
- 'true', 'false' will be matched to their boolean values instead of string values

For these Search rules I used Jison (Javascript Parser Generator) and formed a grammar.jison file, which is used to complete the Search rules highlighted above. 

To access this parser please form a GET request to the endpoint hosted at https://logdna-kamran.herokuapp.com/parse 

This request requires a parameter called input. This will return the proper tree structure expected for the input.

Example request:

https://logdna-kamran.herokuapp.com/parse?input=%22error%20OR%20info%22
