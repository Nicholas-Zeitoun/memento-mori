
const imageCategory = document.querySelector(".new-category-input");
const newCategoryButton = document.querySelector(".add-category");

newCategoryButton.addEventListener('click', () => {
  imageCategory.classList.toggle("d-none");
})

