import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  connect() {
    console.log("Testing controller")
    const intervalID = document.addEventListener("keyup", (event) => {
      if (event.key == "/"){
        this.geolocate()
      }
    })


  }
  sendPosition(position){
    console.log(position.coords)

    fetch(`/bookmarks/nearby?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`).then((r,e)=>{
      console.log("current_position", r)
    })

  }

  geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition((position)=>{
        fetch(`/bookmarks/nearby?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`)
      });
    } else {
      console.log("Geolocation is not supported by this browser.");
    }
  }

}
