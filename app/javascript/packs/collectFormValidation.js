const existingCollection = document.querySelector("#collect_collection_id")
const newCollection = document.querySelector("#collect_collection_name")
document.querySelector("#magic").disabled = true

const checkValid = () => {
  if (existingCollection.value == '' && newCollection.value == '') {
    document.querySelector("#magic").disabled = true
  } else if (existingCollection.value !== '' && newCollection.value !== '') {
    document.querySelector("#magic").disabled = true
  } else {
    document.querySelector("#magic").disabled = false
  }
}

existingCollection.addEventListener('change', () => {
  checkValid();
})

newCollection.addEventListener('change', () => {
  checkValid();
})

// grab both form fields
// check if either have a value
// if neither have a value; disable
