# README

## Strategy

Once i set up the project, i started to think about the main problematic of this challenge: how to search recipes based on a query which contains one or several ingredients.

Of course, one of the main challenge is the performance, the speed to process this query.

Postgresql has nice features to help us to reach this goal.

Here is an article i found during my investigation about postgresql and full text search:
https://pganalyze.com/blog/full-text-search-ruby-rails-postgres

it's talking, in particulary, about "pg_search" gem which allow us to optimize our full text search.

`Recipe.search("betterave")`

```
This is all pretty standard SQL plus a few cool functions: ts_rank, to_tsvector, and to_tsquery. The to_tsvector function in is worth a closer look. It generates tsvector data types, which are “a sorted list of distinct lexemes.” Lexemes, in turn, are “words that have been normalized to make different variants of the same word look alike”.
```

`Recipes` will be a large table as it's already more than 9k records, so we need to cache the "tsvector" for each record, and update it only when new/update operations.

### Importing
About the "importing recipes" step, i decided to create a rake task that will call `ImportRecipes` service, that will process asynchronously the recipes creation.
I decided to do it asynchronously due to the large number of records and also, to give us the ability to handle larger files in the future.


-----

## Deliverables

### Recipes data:
[X] Ability to import recipes from a file

### user stories:
[X] find Recipe by id: `recipes/:id`
[X] find Recipe by ingredients: `recipes/search`
[X] Ability to CRUD on recipes
[X] Ability to use search from external clients (API)

### Demo on Heroku:
[] TODO
-----

- We can go deeper by trying to do an investigation about NLP in order to improve results accuracy.

- We can try to find a solution to avoid duplicated recipes (if necessary)

- We can add more user stories, by using filters like:
  - search_by_preparation_time
  - search_by_difficulty
  - search_by_budget
  - search_by_rating

Or we can also create a multi steps form that will guide the user to identify his need:
- be in a hurry? > how many guests > difficulty > Budget
(PgSearch provide the ability to combine multiple columns)
