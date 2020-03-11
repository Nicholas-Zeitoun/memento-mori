var coll = document.getElementsByClassName("collect-tag");
var overlays = document.querySele
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function(e) {
    e.currentTarget.classList.add("collect-tag-selected")
    overlay = e.currentTarget.parentElement.parentElement.querySelector(".meme-collect-form-overlay")
    overlay.classList.toggle("expand-overlay")
  });
}
