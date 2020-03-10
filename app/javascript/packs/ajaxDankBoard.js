// import "bootstrap";
import img from "images/nyan-cat.gif";

// Retrieve user id and build apiUrl

const createApiUrl = () => {
  if (environment) {
    let apiUrl = 'https://meme-forest.herokuapp.com/api/v1/users/';
    return `${apiUrl}${userId}`
  } else {
    const apiUrl = 'http://localhost:3000/api/v1/users/'
    return `${apiUrl}${userId}`
  }
}

const userSideBar = document.querySelector(".js-dankrefresh")
let nextLvl = parseInt(userSideBar.dataset["nextLvl"]);
const userId = userSideBar.dataset["userId"]
// const apiUrl = `${API_URL}${userId}`

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
          <i class="fas fa-circle"></i>
          <div> ${dankRank['engagement']} </div>
        </div>
        <div class="collection-score col-4">
          <i class="fas fa-circle"></i>
          <div> ${dankRank['collection']} </div>
        </div>
        <div class="creation-score col-4">
          <i class="fas fa-circle"></i>
          <div> ${dankRank['creation']} </div>
        </div>
      </div>
    </div>`
};


const levelUp = () => {
  confetti.start(2000);
  swal({
      title: "Dank Rank Increased!",
      text: "Wow. Very increased. Much Dank 🎉",
      icon: img,
      button: false,
    });
}


const levelCheck = (currentLvl) => {
  if (currentLvl == nextLvl) {
    console.log("level up!");
    levelUp();
    nextLvl += 1;
    userSideBar.dataset.nextLvl = nextLvl
  }
}

const refresh = () => {
  // TODO: Implement the global refresh logic.
  const apiUrl = createApiUrl();
  fetch(apiUrl)
    .then(response => response.json())
    .then((data) => {
      const dankRank = data['dank_rank'];
      updateDankScore(dankRank);
      levelCheck(dankRank['total_score'])
    });
};

// Refresh every 2 second
document.addEventListener("DOMContentLoaded", () => {
  setInterval(refresh, 1000);
});

