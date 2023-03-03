import { Controller } from "@hotwired/stimulus"
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {

    apiKey: String,
    marker: Object
  }
  //static targets = ["directions"]

  connect() {
    console.log("Hello map")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.showDirections()
    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()
    // const button = document.querySelector(".take-me-there");
    // const directions = document.querySelector(".mapboxgl-ctrl-bottom-right");
    //directions.classList.add("hidden");

      //button.addEventListener("click", directions.classList.remove("hidden"))
    //;
  }
  showInstructions() {
    this.showDirections(true)
  }
  showDirections(instructions =false){
    if (this.direction){
      this.map.removeControl(this.direction)
    }
    this.direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      controls: {
        inputs: false,
        instructions: instructions
      },
      routePadding: 35
    })
    this.map.addControl(
      this.direction,
      'bottom-right'
    );
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        this.direction.setOrigin([position.coords.longitude, position.coords.latitude])
        // this.markerValue
        console.log(this.markerValue);
        this.direction.setDestination([this.markerValue.lng, this.markerValue.lat])
      });
    }
  }
  // #addMarkersToMap() {
  //   this.markersValue.forEach((marker) => {
  //     new mapboxgl.Marker()
  //       .setLngLat([marker.lng, marker.lat])
  //       .addTo(this.map)
  //   })
  // }
}
// 1. in maps js controller target your take me there button
// 2. on clicking that button the display: none argument is removed from mapbox-directions-instructions
// 3. in your css file add a default display:none; to the mapbox—directions-instructions class.
// id: “take-me-there”
