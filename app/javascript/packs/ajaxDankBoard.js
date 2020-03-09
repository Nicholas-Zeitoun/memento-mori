const updateDankScore = (innerHTML) => {
  // TODO: update the user's dank score board
  const dankLevel = document.querySelector('.user-sidebar-info');
  dankLevel.innerHTML = innerHTML;;
};

const refresh = () => {
  // TODO: Implement the global refresh logic.
  updateDankScore('<%= j render "shared/components/user_sidebar_info" %>');
};

// Do not remove these lines:
document.addEventListener("DOMContentLoaded", () => {
  setInterval(refresh, 1000); // Every 1 second, the `refresh` function is called.
});
