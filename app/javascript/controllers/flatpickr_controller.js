import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static values = {time: Boolean}
  connect() {
    console.log(this.timeValue)
    new flatpickr(this.element, {
      minDate: "today",
      allowInput: false,
      disable: [
        {
          from: new Date(0),
          to: new Date(new Date().setDate(new Date().getDate() - 1))
        }
      ],
      enableTime: this.timeValue
    });
  }
}
