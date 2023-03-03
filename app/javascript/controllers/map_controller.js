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

    this.direction = new MapboxDirections({
      accessToken: mapboxgl.accessToken,
      controls: {
        inputs: false,
        instructions: false
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
    this.markerValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });

    #fitMapToMarkers() {
      const bounds = new mapboxgl.LngLatBounds()
      this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })

  }
}
}
