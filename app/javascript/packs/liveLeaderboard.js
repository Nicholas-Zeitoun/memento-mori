const createApiUrl = () => {
  if (environment) {
    return "https://meme-forest.herokuapp.com/api/v1/users/leaderboard"
  } else {
    return "http://localhost:3000/api/v1/users/leaderboard"
  }
}

const leaderboardBar = document.querySelector(".leaderboard-card-body")
// const apiUrl = `${API_URL}${userId}`

const buildHtml = (users) => {
  let html = ``;
  users.forEach((user) => {
    let code = `<div class="user-item row mt-1" data-user=${user['id']}>
        <div class="user-name d-flex justify-content-start col-7">
          <a href="/users/${user['id']}">${user['username']}</a>
        </div>

        <div class="user-stats d-flex justify-content-start col-3">
          <div class="user-stats-rank mx-1">
            <span class="badge badge-primary align-baseline"><i class="fas fa-skull-crossbones"></i>
          ${user['level']}</span>
          </div>
          <div class="user-stats-follower">
            <span class="badge badge-secondary align-baseline"><i class="fas fa-trophy"></i> ${user['score']}</span>
          </div>
        </div>
      </div>`
    html = `${html}${code}`
  });
  return html;
}

const updateLeaderboard = (html) => {
  // Update the user's dank score board
  leaderboardBar.innerHTML = html;
};

const refresh = () => {
  // TODO: Implement the global refresh logic.
  const apiUrl = createApiUrl();
  fetch(apiUrl)
    .then(response => response.json())
    .then((data) => {
      updateLeaderboard(buildHtml(data));
    });
};

// Refresh every 2 second
document.addEventListener("DOMContentLoaded", () => {
  setInterval(refresh, 1000);
});
