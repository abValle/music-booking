import { Controller } from "@hotwired/stimulus"
// import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {
  static values = { apiKey: String, markers: Array }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: 'mapbox://styles/mapbox/streets-v12'
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    // this.map.addControl(new MapboxGeocoder({
    //   accessToken: mapboxgl.accessToken,
    //   types: "country,region,place,postcode,locality,neighborhood,address",
    //   mapboxgl: mapboxgl,
    //   trackProximity: false
    // }))
  }

  #addMarkersToMap(){
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map);
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    if (this.markersValue.length > 0) {
      this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    } else {
      const defaultBounds = [[-46.6892309, -23.5517186], [-46.5901063, -23.5565115]]
      defaultBounds.forEach((markers) => {
        bounds.extend([markers[0], markers[1]])
      })
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    }
  }
}
