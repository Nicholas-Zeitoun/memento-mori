// Retrieve user id and build apiUrl
console.log(environment);
if (environment) {
  API_URL = 'https://meme-forest.herokuapp.com/api/v1/users/';
} else {
  API_URL = 'http://localhost:3000/api/v1/users/'
}
const userSideBar = document.querySelector(".js-dankrefresh")
const userId = userSideBar.dataset["userId"]
const apiUrl = `${API_URL}${userId}`

const updateDankScore = (dankRank) => {
  // Update the user's dank score board
  userSideBar.innerHTML = `<h5> Lvl. ${dankRank['total_score']}</h5>
    <div class="dank-rank-section">
      <div class="dank-bar">
        <div class="dank-filler" style="width: ${dankRank['rank_up_bar']}%;">
        </div>
      </div>
      <p><a href="#" class="badge badge-primary mt-2"> ${dankRank['rank_up_xp_progress']} / ${dankRank['rank_up_xp_required']} </a> until next level</p>

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

