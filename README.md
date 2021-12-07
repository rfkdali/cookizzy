# README

## Strategy

Once i set up the project, i started to think about the main problematic of this challenge: how to search recipes based on a query which contains one or several ingredients.

Of course, one of the main challenge is the performance, the speed to process this query.

Postgresql has nice features to help us to reach this goal.

Here is an article i found during my investigation about postgresql and full text search:
https://pganalyze.com/blog/full-text-search-ruby-rails-postgres

it's talking, in particulary, about "pg_search" gem which allow us to optimize our full text search.


`Recipe.search("betterave")`

This is all pretty standard SQL plus a few cool functions: ts_rank, to_tsvector, and to_tsquery. The to_tsvector function in is worth a closer look. It generates tsvector data types, which are “a sorted list of distinct lexemes.” Lexemes, in turn, are “words that have been normalized to make different variants of the same word look alike”.


Recipe will be a large table as it's already more than 5k records, so we need to cache the "tsvector" for each record, and update it only when new/update operations.


As we will do a search on recipes.ingredients, we will use `associated_against:` instead of `against:`
https://github.com/Casecommons/pg_search#searching-through-associations

