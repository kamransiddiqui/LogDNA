Kamran's Solution for the LogDNA Challlenge

This the code for a parser that takes the query DSL given and forms the proper tree structure for it.
This parsing is based on the following rules:
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



To access this please form a GET request to the endpoint hosted at https://logdna-kamran.herokuapp.com/parse 
This request requires a parameter called input. This will return the proper tree structure expected for the input.

Example request:

https://logdna-kamran.herokuapp.com/parse?input=%22error%20OR%20info%22

