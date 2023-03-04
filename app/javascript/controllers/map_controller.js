import { Controller } from "@hotwired/stimulus"
import MapboxDirections from '@mapbox/mapbox-gl-directions/dist/mapbox-gl-directions'

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object
  }

  connect() {
    console.log("Hello map")
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    // this.#addMarkersToMap()
    // this.#fitMapToMarkers()

    const direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      controls: {
        inputs: false,
        instructions: false
      }
    })
    this.map.addControl(
      direction,
      'bottom-right'

    );
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position) => {
        direction.setOrigin([position.coords.longitude, position.coords.latitude])
        // this.markerValue
        console.log(this.markerValue);
        direction.setDestination([this.markerValue.lng, this.markerValue.lat])
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
