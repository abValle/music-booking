import { Controller } from "@hotwired/stimulus";
import { Popover } from "bootstrap";

export default class extends Controller {
  connect() {
    new Popover(this.element)
  }
}
