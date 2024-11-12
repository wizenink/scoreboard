import consumer from "./consumer"

const subscribeToMatchChannel = (matchId) => {
  return consumer.subscriptions.create(
      { channel: "MatchChannel", match_id: matchId},
      {
        connected() {
          console.log(`Connected to match channel ${matchId}`);
        },
        disconnected() {
          console.log(`Disconnected to match channel ${matchId}`);

        },
        received(data) {

          const prodShowElement = document.getElementById("prodshow");
          if(prodShowElement) {
              let score_team_a = document.getElementById('score-team-a')
              let score_team_b = document.getElementById('score-team-b')
              score_team_a.classList.add("transform", "scale-125", "transition-transform", "duration-300", "ease-out");
              score_team_b.classList.add("transform", "scale-125", "transition-transform", "duration-300", "ease-out");
              setTimeout(() => {
                  score_team_a.innerText = data.goals_team_a;
                  score_team_b.innerText = data.goals_team_b;
              },150);

              setTimeout(() => {
                  score_team_a.classList.remove("scale-125");
                  score_team_a.classList.add("scale-100");

                  score_team_b.classList.remove("scale-125");
                  score_team_b.classList.add("scale-100");
              },300);
          }
          else {
              document.getElementById('score-team-a').innerText = data.goals_team_a;
              document.getElementById('score-team-b').innerText = data.goals_team_b;
          }
        }
      }
  )
};

document.addEventListener("DOMContentLoaded", () => {
  const matchElement = document.getElementById("match-id");
  if(matchElement) {
    const matchId = matchElement.dataset.matchId;
    subscribeToMatchChannel(matchId);
  }
});