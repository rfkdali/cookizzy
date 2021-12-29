# README

## Deliverables

### Recipes data:
- [x] Ability to import recipes from a file

### user stories:
- [x] Find Recipes: `recipes`
- [x] Find Recipe by id: `recipes/:id`
- [x] Find Recipe by ingredients: `recipes/search`
- [x] Ability to CRUD on recipes
- [x] Ability to use search from external clients (API)
  - Recipes: `GET https://cookizzy.herokuapp.com/recipes.json`
  - Recipe: `GET https://cookizzy.herokuapp.com/recipes/{recipe_id}.json`
  - Search recipes: `GET https://cookizzy.herokuapp.com/recipes/search?ingredients='roquefort, boeuf, champignon'`
- [x] Ability to use search with autocomplete feature (with React)

### Demo on Heroku:
- [x] https://cookizzy.herokuapp.com/

### Install project locally
- Setup DB with`rake db:create && rake db:migrate`
- Import recipes `rake recipes:import && bundle exec sidekiq`
- Go to `localhost:3000`

### Testing with rspec

-----

### Nice to have improvements

- We can go deeper by trying to do an investigation about NLP in order to improve results accuracy.

- We can try to find a solution to avoid duplicated recipes (if necessary)

- We can add more user stories, by using filters like:
  - search_by_preparation_time
  - search_by_difficulty
  - search_by_budget
  - search_by_rating
  - search_by_tags (as vegeterian, without gluten, cheese-lover, bodybuilder)

Or we can also create a multi steps form that will guide the user to identify his need:
- be in a hurry? > how many guests > difficulty > Budget

----

#### Notes 10/12/2021
I added some improvements as i noticed that search queries were not efficient enough, and i found that i forgot to specify (again) `tsvector_column`.
Results: It improved search query significantly (**from 800ms to 20ms!**)
```
Recipe.search_by_ingredients('creme, poulet')
  Recipe Load (801.0ms)
```
To

```
Recipe.search_by_ingredients('creme, poulet')
  Recipe Load (21.4ms)
```
