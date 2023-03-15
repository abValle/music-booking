import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { proposalId: Number }
  static targets = ["messages"]

  connect() {

    this.channel = createConsumer().subscriptions.create(
      { channel: "ProposalChannel", id: this.proposalIdValue },
      { received:  data => this.#insertMessageAndScrollDown(data)}
    )
  }

  resetForm(event) {
    event.target.reset()
  }

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    this.channel.unsubscribe()
  }

}
