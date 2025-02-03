<template>
  <div class="search-widget">
    <h2>Search Hotels</h2>

    <div class="form-group">
      <label for="city">City</label>
      <input
        id="city"
        v-model="city"
        placeholder="Enter city"
        class="search-input"
      />
    </div>

    <div class="form-group">
      <label for="adults">Number of Adults</label>
      <select id="adults" v-model="adults" class="select-input">
        <option value="1">1 Adult</option>
        <option value="2">2 Adults</option>
        <option value="3">3 Adults</option>
        <option value="4">4 Adults</option>
      </select>
    </div>

    <!-- Search Button -->
    <div class="form-group">
      <button @click="fetchResults" class="search-button">Search</button>
    </div>

    <div class="results">
      <ul v-if="results && results.length">
        <li v-for="item in results" :key="item.id" class="result-item">
          <h4>{{ item.title }}</h4>
          <p class="nickname"><strong>Nickname:</strong> {{ item.nickname }}</p>
          <p class="city-name"><strong>City:</strong> {{ item.city_name }}</p>
          <p class="beds-baths">
            <strong>Beds:</strong> {{ item.beds }} | 
            <strong>Baths:</strong> {{ item.baths }}
          </p>
          <p class="amenities">
            <strong>Amenities:</strong>
            <span v-for="(amenity, index) in item.amenities" :key="index">
              {{ amenity }}{{ index < item.amenities.length - 1 ? ', ' : '' }}
            </span>
          </p>
        </li>
      </ul>
      <p v-else class="no-results">No results found</p>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      city: "",
      adults: 1,
      results: []
    };
  },
  methods: {
    async fetchResults() {
      // Ensure that a city is provided before making the request
      if (this.city.length < 1) {
        this.results = [];
        return;
      }
      try {
        // Fetch data based on city and number of adults
        const response = await axios.get(`/search.json`, {
          params: {
            city: this.city,
            adults: this.adults
          }
        });
        this.results = response.data;  // Adjust based on API response structure
      } catch (error) {
        console.error("Search error:", error);
      }
    }
  }
};
</script>

<style scoped>
/* Container for the search widget */
.search-widget {
  max-width: 600px;
  margin: 40px auto;
  padding: 20px;
  border-radius: 8px;
  background-color: #f9f9f9;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h2 {
  text-align: center;
  font-family: 'Arial', sans-serif;
  font-size: 24px;
  margin-bottom: 20px;
}

.form-group {
  margin-bottom: 20px;
}

label {
  font-size: 16px;
  font-weight: 600;
  display: block;
  margin-bottom: 8px;
}

.search-input, .select-input {
  width: 100%;
  padding: 12px;
  border-radius: 5px;
  border: 1px solid #ccc;
  font-size: 16px;
  box-sizing: border-box;
}

.search-input:focus, .select-input:focus {
  border-color: #4CAF50;
  outline: none;
}

.select-input {
  appearance: none;
  background-color: white;
  background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" fill="none" width="12" height="8"><path d="M0 0l6 6 6-6z" fill="#000"></path></svg>');
  background-repeat: no-repeat;
  background-position: right 10px center;
  background-size: 12px;
}

.results {
  margin-top: 20px;
}

.result-item {
  background-color: #fff;
  padding: 20px;
  margin-bottom: 15px;
  border-radius: 5px;
  border: 1px solid #eee;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.result-item h4 {
  font-size: 18px;
  margin: 0 0 10px;
  color: #333;
}

.nickname, .city-name, .beds-baths, .amenities, .summary {
  font-size: 14px;
  color: #555;
  margin-bottom: 8px;
}

.nickname strong, .city-name strong, .beds-baths strong, .amenities strong, .summary strong {
  font-weight: 600;
}

.amenities span {
  display: inline-block;
  margin-right: 10px;
}

.no-results {
  font-size: 16px;
  color: #888;
  text-align: center;
  margin-top: 20px;
}

.search-input, .select-input {
  font-size: 16px;
  font-weight: 400;
}

/* Search button styling */
.search-button {
  width: 100%;
  padding: 12px;
  font-size: 16px;
  background-color: #4CAF50;
  color: white;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
}

.search-button:hover {
  background-color: #45a049;
}

@media (max-width: 600px) {
  .search-widget {
    padding: 15px;
    margin: 20px;
  }

  h2 {
    font-size: 20px;
  }

  .form-group {
    margin-bottom: 15px;
  }

  .search-input, .select-input {
    padding: 10px;
  }
}
</style>