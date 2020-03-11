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
  let rank = 0;
  users.forEach((user) => {
    let code = `<div class="user-item row align-items-center" data-user=${user['id']}>
                  <div class="user-rank col-1 pb-0">
                    <h5 class="pl-1 pt-1">${rank + 1}</h5>
                  </div>

                  <div class="user-avatar col-2 p-1">
                    <img src="${user['avatar']}" class="avatar"/>
                  </div>

                  <div class="user-name col-5 p-1">
                    <a href="/users/${user['id']}">${user['username']}</a>
                  </div>

                  <div class="user-stats d-flex col-3 p-0">
                    <div class="user-stats-rank mx-1">
                      <span class="badge badge-primary"><i class="fas fa-skull-crossbones"></i>
                    ${user['level']}</span>
                    </div>

                    <div class="user-stats-follower">
                      <span class="badge badge-secondary"><i class="fas fa-trophy"></i> ${user['score']}</span>
                    </div>
                  </div>
                </div>`
    html = `${html}${code}`
    rank +=1
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
