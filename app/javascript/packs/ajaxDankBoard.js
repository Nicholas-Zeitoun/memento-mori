// Retrieve user id and build apiUrl
const userSideBar = document.querySelector(".js-dankrefresh")
const userId = userSideBar.dataset["userId"]
const apiUrl = `http://localhost:3000/api/v1/users/${userId}`

const updateDankScore = (dankRank) => {
  // Update the user's dank score board
  userSideBar.innerHTML = `<h5> Lvl. ${dankRank['total_score']}</h5>
  <div class="dank-rank-section">
    <div class="dank-bar">
      <div class="dank-filler">
      </div>
    </div>
    <p><a href="#" class="badge badge-primary mt-2">89 / 123</a> until next level</p>
    <div class="row text-center">
      <div class="engagement-score col-4">
        <i class="fas fa-circle"></i> ${dankRank['engagement']}
      </div>
      <div class="collection-score col-4">
        <i class="fas fa-circle"></i> ${dankRank['collection']}
      </div>
      <div class="creation-score col-4">
        <i class="fas fa-circle"></i> ${dankRank['creation']}
      </div>
    </div>
  </div>`
};

const refresh = () => {
  // TODO: Implement the global refresh logic.
  fetch(apiUrl)
    .then(response => response.json())
    .then((data) => {
      const dankRank = data['dank_rank'];
      updateDankScore(dankRank);
    });
};

// Refresh every 2 second
document.addEventListener("DOMContentLoaded", () => {
  setInterval(refresh, 1000);
});

