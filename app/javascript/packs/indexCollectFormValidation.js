const forms = document.querySelectorAll("#new_collect")

const switchColl = (form) => {
  const newCollection = form.querySelector(".new-collection-input");
  const existingCollection = form.querySelector(".existing-collection-input");
  const newCollectionButton = form.querySelector(".add-collection");

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
};

forms.forEach((form) => {
  const newCollection = form.querySelector(".new-collection-input");
  const existingCollection = form.querySelector(".existing-collection-input");
  const newCollectionButton = form.querySelector(".add-collection");

  switchColl(form);
});
