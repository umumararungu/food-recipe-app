const app_id = 'YOUR_APP_ID';
const app_key = 'YOUR_APP_KEY';
const recipe_name = 'chicken';

fetch(`https://api.edamam.com/search?q=${recipe_name}&app_id=${app_id}&app_key=${app_key}`)
  .then(response => response.json())
  .then(data => console.log(data.hits))
  .catch(error => console.error(error));