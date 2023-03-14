import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  connect() {
    new flatpickr(this.element, {
      enableTime: true,
      minDate: "today",
      disable: [
        {
          from: new Date(0),
          to: new Date(new Date().setDate(new Date().getDate() - 1))
        }
      ]
      // more options available on the documentation!
    });
  }


}
