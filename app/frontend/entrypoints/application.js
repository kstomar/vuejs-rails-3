import { createApp } from "vue";
import SearchWidget from "../components/SearchWidget.vue";

document.addEventListener("DOMContentLoaded", () => {
  const app = createApp(SearchWidget);
  app.mount("#search-widget");
});
