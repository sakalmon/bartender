let searchBar = document.querySelector('.search-bar input');
console.log(searchBar);

searchBar.addEventListener('click', function(event) {
  event.target.value = ''
});
