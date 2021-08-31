var menu_something = document.querySelector(".menu");
var hamburger = document.getElementById("hamburger")
// debugger;
hamburger.addEventListener('click', menuToggle())

function menuToggle() {
  debugger;
  menu_something.classList.toggle('.active')
}
