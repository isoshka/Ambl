import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }
  //static targets = ["directions"]

  connect() {
    console.log("Hello map")
    mapboxgl.accessToken = this.apiKeyValue



    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    });


    // this.showDirections()
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()
    // const button = document.querySelector(".take-me-there");
    // const directions = document.querySelector(".mapboxgl-ctrl-bottom-right");
    //directions.classList.add("hidden");

      //button.addEventListener("click", directions.classList.remove("hidden"))
    //;
  }

  #addMarkersToMap() {
    console.log("markers are ready",this.markersValue)
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
// 1. in maps js controller target your take me there button
// 2. on clicking that button the display: none argument is removed from mapbox-directions-instructions
// 3. in your css file add a default display:none; to the mapbox—directions-instructions class.
// id: “take-me-there”
}
