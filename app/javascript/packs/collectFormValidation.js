const newCollection = document.querySelector(".new-collection-input");
const existingCollection = document.querySelector(".existing-collection-input");
const newCollectionButton = document.querySelector(".add-collection");

newCollectionButton.addEventListener('click', () => {
  newCollection.classList.toggle("d-none");
  if (newCollection.classList.contains("d-none")) {
    newCollectionButton.innerText = "Or use an existing collection"
    existingCollection.classList.remove("d-none")
  } else {
    newCollectionButton.innerText = "Or create a new one to add this meme to"
    existingCollection.classList.add("d-none")
  }
})
