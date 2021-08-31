let menu = document.querySelector(".menu");
let hamburger = document.getElementById("hamburger")
  debugger;
hamburger.addEventListener('click', menuToggle())

function menuToggle() {
  menu.classList.toggle('.active')
}
