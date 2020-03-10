import "bootstrap";
import { $, jQuery } from "jquery";
import { initSweetalert } from '../plugins/init_sweetalert';

initSweetalert('#sweet-alert-demo', {
  title: "Dank Rank Increased!",
  text: "Wow! Way to go you memetacular fellow! 🎉"
}, (value) => {
  console.log('confetti!!');
  confetti.start(2000)
});

