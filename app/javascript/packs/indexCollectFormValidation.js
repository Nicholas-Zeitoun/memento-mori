const forms = document.querySelectorAll("#new_collect")

document.querySelectorAll("#magic").forEach((magic) => {
  magic.disabled = true
  });

const checkValid = (form) => {
  const existingColl = form.querySelector("#collect_collection_id")
  const newColl = form.querySelector("#collect_collection_name")
  if (existingColl.value == '' && newColl.value == '') {
    form.querySelector("#magic").disabled = true
  } else if (existingColl.value !== '' && newColl.value !== '') {
    form.querySelector("#magic").disabled = true
  } else {
    form.querySelector("#magic").disabled = false
  }
};

forms.forEach((form) => {
  const existingCollection = form.querySelector("#collect_collection_id")
  const newCollection = form.querySelector("#collect_collection_name")

  existingCollection.addEventListener('change', () => {
  checkValid(form);
  })

  newCollection.addEventListener('change', () => {
    checkValid(form);
  })
});
